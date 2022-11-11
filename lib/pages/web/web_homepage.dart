// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/services/spotify_service.dart';
import 'package:flutter_portfolio/utils/constants.dart';
import 'package:flutter_portfolio/widgets/reusable/chip_container.dart';
import 'package:flutter_portfolio/widgets/reusable/chip_text.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'dart:js' as js;
import '../../animations/on_hover.dart';
import '../../data/data.dart';
import '../../models/git_models.dart';
import '../../services/github_service.dart';
import '../../theme/colors.dart';
import '../../utils/footer.dart';
import '../../utils/openMail_card.dart';
import '../../widgets/featured_card.dart';
import '../../widgets/loader.dart';
import '../../widgets/snackbars.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  late Future<AllRepos> futureRepo;
  @override
  void initState() {
    futureRepo = fetchRepos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final messageController = TextEditingController();
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Row(
        children: [
          SizedBox(width: MediaQuery.of(context).size.width / 5),
          //homepage column
          _body(context, messageController),
          SizedBox(width: MediaQuery.of(context).size.width / 5),
        ],
      ),
    );
  }

  _body(BuildContext context, TextEditingController messageController) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.11),
          _initialDescription(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.09),
          _checkOtherPortfolio(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.09),
          _featuredCreations(),
          const SizedBox(height: 20),
          _currentWorks(),
          const SizedBox(height: 20),
          const NewsLetterCard(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.09,
            child: const Divider(),
          ),
          _footerSection(),
        ],
      ),
    );
  }

  _checkOtherPortfolio() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: GlassmorphicContainer(
        width: double.maxFinite,
        height: 50,
        borderRadius: 8,
        alignment: Alignment.center,
        linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFffffff).withOpacity(0.1),
              const Color(0xFFFFFFFF).withOpacity(0.1),
            ],
            stops: const [
              0.1,
              1,
            ]),
        borderGradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.transparent, Colors.transparent],
        ),
        border: 2,
        blur: 20,
        child: RichText(
          text: TextSpan(
            text: 'While you are here, why not take a tour of ',
            style: GoogleFonts.ubuntu(
              color: Colors.white,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'ansy.io',
                style: GoogleFonts.ubuntu(color: Colors.blue),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    js.context
                        .callMethod('open', ["https://ansy-io.vercel.app/"]);
                  },
              ),
              TextSpan(
                text: " as well, plus sign my guestbook",
                style: GoogleFonts.ubuntu(),
              )
            ],
          ),
        ),
      ),
    );
  }

  _initialDescription() {
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
                //individual text widgets for full control over text
                Text(
                  Constants.name,
                  style: GoogleFonts.ubuntu(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    Constants.description,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.ubuntu(
                      color: Colors.white38,
                      fontSize: 17,
                    ),
                  ),
                ),
                Text(
                  Constants.moreDescription,
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  style: GoogleFonts.ubuntu(
                    color: Colors.white38,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 5),
                _locationRow()
              ],
            ),
          ),
        ),
        //developer image
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 55,
            backgroundImage: NetworkImage(Constants.image),
          ),
        ),
      ],
    );
  }

  _locationRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 5.0),
          child: Icon(Iconsax.location, color: Colors.deepPurple),
        ),
        const SizedBox(width: 4),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            Constants.location,
            textAlign: TextAlign.start,
            maxLines: 2,
            style: GoogleFonts.nunitoSans(
              color: Colors.white70,
            ),
          ),
        ),
      ],
    );
  }

  _featuredCreations() {
    double boxSize =
        MediaQuery.of(context).size.height > MediaQuery.of(context).size.width
            ? MediaQuery.of(context).size.width / 2
            : MediaQuery.of(context).size.height / 2.5;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Featured Projects",
          style: GoogleFonts.lora(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: boxSize - 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: creations.length,
            itemBuilder: (_, index) {
              return FeatureCard(
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
              onPressed: () {
                js.context.callMethod(
                    'open', ["https://github.com/Anslem27?tab=repositories"]);
              },
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
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Open Source Projects",
              style:
                  GoogleFonts.ubuntu(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 5),
            const ChipContainer(color: Colors.deepOrangeAccent, text: "Github"),
            const Spacer(),
            ChipText(
              text: "Up to date",
              color: colors["primary"] as Color,
            ),
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
                                style: GoogleFonts.nunitoSans(),
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

  _footerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Social",
          style: GoogleFonts.ubuntu(fontSize: 20, fontWeight: FontWeight.bold),
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
                  InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      js.context.callMethod('open', [
                        "https://www.reddit.com/user/${Constants.redditUserName}"
                      ]);
                    },
                    child: ChipText(
                      text: Constants.redditUserName,
                      color: const Color(0xffff5700),
                    ),
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
                  InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      js.context.callMethod('open',
                          ["https://twitter.com/${Constants.twitterUserName}"]);
                    },
                    child: ChipText(
                      text: Constants.twitterUserName,
                      color: const Color(0xff00acee),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () async {},
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
                InkWell(
                  onTap: () {
                    js.context.callMethod('open', [Constants.spotifyUserLink]);
                  },
                  child: FutureBuilder(
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
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
