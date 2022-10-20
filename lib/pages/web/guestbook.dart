// ignore_for_file: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/widgets/loader.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import '../../utils/footer.dart';
import 'package:intl/intl.dart';
import '../../widgets/reusable/chip_container.dart';
import '../../widgets/snackbars.dart';

class GuestBook extends StatefulWidget {
  const GuestBook({super.key});

  @override
  State<GuestBook> createState() => _GuestBookState();
}

class _GuestBookState extends State<GuestBook> {
  final guestmessageController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: LayoutBuilder(
          builder: (_, constraints) {
            if (constraints.maxWidth < 600) {
              return Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width / 20),
                  _guestBookbody(),
                  SizedBox(width: MediaQuery.of(context).size.width / 20),
                ],
              );
            } else {
              return Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width / 5),
                  _guestBookbody(),
                  SizedBox(width: MediaQuery.of(context).size.width / 5),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  _guestBookbody() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.11),
          _topText(),
          const SizedBox(height: 20),
          _logBookSection(guestmessageController, nameController),
          SizedBox(height: MediaQuery.of(context).size.height * 0.11),
          const Footer()
        ],
      ),
    );
  }

  _topText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "GuestBook",
                      style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 45,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Flexible(
                      child: ChipContainer(
                        text: "Beta",
                        color: Colors.deepPurple,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            content: InfoToast(
                              title: "GuestBook Message",
                              body:
                                  "GuestBook is somewhat moderated, so try to keep it clean",
                              widget: Icon(
                                Iconsax.eye,
                                size: 16,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ),
                        );
                      },
                      splashRadius: 24,
                      icon: const Icon(
                        Icons.info_outline,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "This is where you can leave a message for future visitors, it could be anything,an appreciation,suggestion, make it memorable. Database courtesy of Firebase.",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.nunitoSans(
                      color: Colors.white38,
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _logBookSection(TextEditingController guestmessageController,
      TextEditingController nameController) {
    //date variables
    DateTime now = DateTime.now();
    String date = DateFormat('dd').format(now);
    String moyear = DateFormat('MMM yyyy').format(now);
    String time = DateFormat('kk:mm a').format(now);
    String formattedDate = "${date}th $moyear at $time";
    //
    bool showSuccess = false;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(builder: (_, constraints) {
          return GlassmorphicContainer(
            padding: const EdgeInsets.all(8),
            width: constraints.maxWidth < 800
                ? MediaQuery.of(context).size.width / 1.3
                : MediaQuery.of(context).size.width / 1.8,
            borderRadius: 8,
            height: constraints.maxWidth < 800
                ? MediaQuery.of(context).size.height / 3
                : MediaQuery.of(context).size.height / 3.2,
            blur: 20,
            border: 2,
            linearGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFFffffff).withOpacity(0.1),
                  const Color(0xFFFFFFFF).withOpacity(0.05),
                ],
                stops: const [
                  0.1,
                  1
                ]),
            borderGradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff7fffd4),
                Colors.blue,
                Colors.purple,
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Create memory,with Guestbook.",
                      style: GoogleFonts.roboto(fontSize: 25),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
                    child: Text(
                      "Share a message for future visitors to the website.",
                      style: GoogleFonts.roboto(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              padding: const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.black,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: TextField(
                                  controller: guestmessageController,
                                  keyboardType: TextInputType.multiline,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Your message',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              padding: const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.black,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: TextField(
                                  controller: nameController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Your name',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 8),
                    child: InkWell(
                      splashColor: Colors.deepPurple,
                      onTap: () async {
                        FirebaseFirestore.instance
                            .collection("Guests")
                            .add({
                              "message": guestmessageController.text,
                              "user_name": nameController.text,
                              "creation_date": formattedDate
                            })
                            .then((value) {})
                            .catchError(
                              (onError) {
                                throw Exception();
                              },
                            );

                        setState(() {
                          showSuccess = true;
                          nameController.clear();
                          guestmessageController.clear();
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.black,
                        ),
                        alignment: Alignment.center,
                        child: const Padding(
                          padding: EdgeInsets.only(left: 8.0, right: 8),
                          child: Text("Submit"),
                        ),
                      ),
                    ),
                  ),
                  showSuccess == true
                      ? Row(
                          children: [
                            const Icon(Icons.done_rounded,
                                color: Color(0xff7fffd4)),
                            Text(
                              "Awesome, thats for checkin' my Guestbook.",
                              style: GoogleFonts.roboto(
                                color: Colors.deepPurple,
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          );
        }),
        SizedBox(height: MediaQuery.of(context).size.height * 0.11),
        StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Guests").snapshots(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                height: 30,
                child: Loader(),
              );
            } else {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (_, index) {
                  return _guestDataListTile(
                    () {},
                    () async {
                      //? TODO: Activate to delete something as a means of moderation

                      // await FirebaseFirestore.instance
                      //     .runTransaction((Transaction myTransaction) async {
                      //   myTransaction.delete(
                      //     snapshot.data!.docs[index].reference,
                      //   );
                      // });
                    },
                    snapshot.data!.docs[index],
                    //
                    index,
                  );
                },
              );
            }
          },
        )
      ],
    );
  }

  _guestDataListTile(Function()? onTap, Function()? delete,
      QueryDocumentSnapshot doc, int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: IconButton(
            splashRadius: 24,
            onPressed: delete,
            color: index.isEven ? Colors.deepPurple : const Color(0xff1DB954),
            icon: const Icon(Iconsax.book),
          ),
          title: Text(doc["message"]),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 3.0, bottom: 5),
            child: Text(
              doc["creation_date"],
              style: const TextStyle(
                color: Colors.grey,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          trailing: Text(
            doc["user_name"],
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          onTap: onTap,
        ),
        const SizedBox(height: 8),
        const Divider()
      ],
    );
  }
}
