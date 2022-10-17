// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:js' as js;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../animations/on_hover.dart';
import '../../data/data.dart';
import '../../models/git_models.dart';
import '../../services/github_service.dart';
import '../../services/spotify_service.dart';
import '../../utils/constants.dart';
import '../../utils/footer.dart';
import '../../widgets/featured_card.dart';
import '../../widgets/loader.dart';
import '../../widgets/reusable/chip_container.dart';
import '../../widgets/reusable/chip_text.dart';

class MobileHomePage extends StatefulWidget {
  const MobileHomePage({super.key});

  @override
  State<MobileHomePage> createState() => _MobileHomePageState();
}

class _MobileHomePageState extends State<MobileHomePage> {
  late Future<AllRepos> futureRepo;
  @override
  void initState() {
    futureRepo = fetchRepos();
    super.initState();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: _body(),
    );
  }

  _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        _topText(),
        SizedBox(height: MediaQuery.of(context).size.height * 0.09),
        _featuredCreations(),
        const SizedBox(height: 20),
        _currentWorks(),
        const SizedBox(height: 20),
        _directMail(),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.09,
          child: const Divider(),
        ),
        _footerSection(),
      ],
    );
  }

  _topText() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(Constants.image),
          ),
        ),
        Text(
          Constants.name,
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            Constants.description,
            maxLines: 2,
            textAlign: TextAlign.start,
            style: GoogleFonts.roboto(
              fontSize: 16,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, top: 7),
          child: Text(
            Constants.moreDescription,
            textAlign: TextAlign.start,
            maxLines: 2,
            style: GoogleFonts.roboto(color: Colors.grey, fontSize: 15),
          ),
        ),
      ],
    );
  }

  _featuredCreations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Featured Projects",
          style: GoogleFonts.nunitoSans(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          itemCount: creations.length,
          itemBuilder: (_, index) {
            return MobileFeatureCard(
              title: creations[index],
              description: creationDescription[index],
              gradient: cardColors[index],
              onTap: () {
                //call url method from featured url list
                js.context.callMethod('open', [featuredUrls[index]]);
              },
            );
          },
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 11.0),
              child: Text(
                "Check them all",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            IconButton(
              splashRadius: 24,
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_forward_outlined,
              ),
            ),
          ],
        )
      ],
    );
  }

  _currentWorks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "OpenSource Projects",
              style:
                  GoogleFonts.nunitoSans(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const ChipContainer(
                color: Colors.deepOrangeAccent, text: "Fetched from Github"),
            const SizedBox(height: 5),
          ],
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: FutureBuilder(
            future: futureRepo,
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                List<Repo> repo = <Repo>[];
                for (int i = 0; i < snapshot.data!.repo!.length; i++) {
                  repo.add(
                    Repo(
                      name: snapshot.data!.repo![i].name,
                      htmlUrl: snapshot.data!.repo![i].htmlUrl,
                      stargazersCount: snapshot.data!.repo![i].stargazersCount,
                      description: snapshot.data!.repo![i].description,
                    ),
                  );
                }
                return ListView(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: repo
                      .take(5)
                      .map(
                        (e) => Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text(
                                e.name.toString(),
                              ),
                              subtitle: Text(
                                e.description.toString() == "null"
                                    ? "No description"
                                    : e.description.toString(),
                              ),
                              onTap: () {},
                              trailing: OnHover(
                                builder: (isHovered) {
                                  return OutlinedButton.icon(
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.all(5),
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {
                                      js.context
                                          .callMethod('open', [e.htmlUrl]);
                                    },
                                    icon: const Icon(Iconsax.folder_open,
                                        color: Colors.white),
                                    label: const Text(
                                      "Read more",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const Divider()
                          ],
                        ),
                      )
                      .toList(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Failed to fetch contents'),
                );
              } else {
                //circular indicator
                return const SizedBox(height: 25, child: Loader());
              }
            },
          ),
        ),
      ],
    );
  }

  _directMail() {
    double boxSize =
        MediaQuery.of(context).size.height > MediaQuery.of(context).size.width
            ? MediaQuery.of(context).size.width / 2
            : MediaQuery.of(context).size.height / 2.5;
    return Container(
      width: double.maxFinite - 50,
      height: boxSize - 50,
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
                  const Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(left: 8.0, bottom: 15),
                    child: TextField(
                      decoration: InputDecoration(
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

  _footerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          "Social",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        _socials(),
        SizedBox(height: MediaQuery.of(context).size.height * 0.11),
        const Footer()
      ],
    );
  }

  _socials() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/icons/reddit.png",
                    height: 25,
                    width: 25,
                  ),
                  const SizedBox(width: 4),
                  ChipText(
                    text: Constants.redditUserName,
                    color: const Color(0xffff5700),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
                child: Divider(
                  color: Color(0xff00acee),
                  thickness: 2,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/icons/twitter.png",
                    height: 25,
                    width: 25,
                  ),
                  const SizedBox(width: 4),
                  ChipText(
                    text: Constants.twitterUserName,
                    color: const Color(0xff00acee),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () async {
              // var url =
              //     Uri.parse(SpotifyService().getSpotifyUri().toString());
              // print(url);
              // if (!await launchUrl(url)) {
              //   throw 'Could not launch $url';
              // }
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/icons/spotify.png",
                  height: 25,
                  width: 25,
                ),
                const SizedBox(width: 4),
                FutureBuilder(
                  future: SpotifyService().getUsername(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      return ChipText(
                        text: snapshot.data.toString(),
                        color: const Color(0xff1DB954),
                      );
                    } else {
                      return const ChipText(
                        text: "Check out what am listening to...",
                        color: Color(0xffffffff),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
