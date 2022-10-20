// import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsLetterCard extends StatefulWidget {
  const NewsLetterCard({super.key});

  @override
  State<NewsLetterCard> createState() => _NewsLetterCardState();
}

class _NewsLetterCardState extends State<NewsLetterCard> {
  final messageController = TextEditingController();
  late String email, sentResponse;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite - 50,
      //height: boxSize - 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromARGB(255, 21, 21, 21),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 8.0, right: 8, bottom: 8, top: 15),
            child: Text(
              "Send me a direct message.",
              textAlign: TextAlign.start,
              style:
                  GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Text(
              "Have something special to share, then write to me directly an share your thoughts",
              maxLines: 2,
              textAlign: TextAlign.start,
              style: GoogleFonts.roboto(
                color: Colors.white38,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: const EdgeInsets.only(left: 2, right: 8),
              height: 50,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey.shade900,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 15),
                    child: TextField(
                      controller: messageController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Your message',
                      ),
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromARGB(255, 21, 21, 21),
                      ),
                      alignment: Alignment.center,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 8),
                        child: Text("Submit"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> submit() async {}
}

//serverless funtions

//  https://youtu.be/h3cjH8woLXE

// twitter api  https://pub.dev/packages/twitter_api_v2#12-getting-started-

//reddit api, or twitter api
/* 
class NewsletterCard extends StatefulWidget {
  const NewsletterCard({super.key});

  @override
  _NewsletterCardState createState() => _NewsletterCardState();
}

class _NewsletterCardState extends State<NewsletterCard> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? sentResponse;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Text(
                "Join Our Newsletter",
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                "Be one of the first to be notified when\nListwell is released",
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.symmetric(horizontal: 42),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                  style: Theme.of(context).textTheme.headline5,
                  onSaved: (email) => this.email = email,
                  validator: (value) {
                    if (value.isNotEmpty()) {
                      return 'Enter a correct email address';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 12),
              if (isLoading)
                CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                )
              else ...[
                if (sentResponse == null)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    child: ButtonTheme(
                      minWidth: double.infinity,
                      child: CustomRaisedButton(
                        title: "Subscribe",
                        onTap: submit,
                      ),
                    ),
                  )
                else
                  Text(
                    sentResponse!,
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        setState(() {
          isLoading = true;
        });
        final response = await http.post(
          "OUR_CLOUD_FUNCTION_API",
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Access-Control-Allow-Origin': '*',
          },
          body: jsonEncode({"email": email}),
        );
        if (response.statusCode == 200) {
          setState(() {
            sentResponse = "Check your email for confirmation!";
            isLoading = false;
          });
        } else {
          setState(() {
            sentResponse = response.body;
            isLoading = false;
          });
        }
      } catch (e) {
        setState(() {
          sentResponse = "Something went wrong, please try again";
          isLoading = false;
        });
      }
    }
  }
} */
