import * as functions from 'firebase-functions';
// @ts-ignore incorrect typescript typings
import * as Mailchimp from "mailchimp-api-v3";


/* 

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

var cors = require("cors");

const corsHandler = cors({ origin: true });

const _mailChimpId = "MY_MAIL_CHIMP_ID";  
const _apiKey = "MY_API_KEY"; 

*/
var cors = require('cors');
const corsHandler = cors({ origin: true });
const _mailChimpId = "MY_MAIL_CHIMP_ID";
const _apiKey = "MY_API_KEY";
let mailchimp: Mailchimp;
try {
    mailchimp = new Mailchimp(_apiKey);
} catch (err) {
    console.log(err);
}
exports.mailChimp = functions.https.onRequest((req, res) => {
    corsHandler(req, res, async () => {
        const email = req.body.email;
        try {
            console.log("adding user")
            const results = await mailchimp.post(
                `/lists/${_mailChimpId}/members`,
                {
                    email_address: email,
                    status: "pending",
                }
            );
            console.log(`Added user: ${email} status PENDING to Mailchimp audience: ${_mailChimpId}`);
            res.status(200).send('Success adding the user to the mailchimp list');
        } catch (error) {
            console.error("Error when adding user to Mailchimp audience", error);
            res.send(error);
        }
    });
});