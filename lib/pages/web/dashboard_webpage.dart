// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:flutter_portfolio/services/spotify_service.dart';
import 'package:flutter_portfolio/utils/constants.dart';
import 'package:flutter_portfolio/widgets/loader.dart';
import 'package:flutter_portfolio/widgets/responsive_layout.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:js' as js;
import '../../services/github_service.dart';
import '../../services/reddit_service.dart';
import '../../utils/footer.dart';
import '../../widgets/reusable/chip_container.dart';
import '../../widgets/reusable/social_image_card.dart';

class WebDashBoard extends StatefulWidget {
  const WebDashBoard({super.key});

  @override
  State<WebDashBoard> createState() => _WebDashBoardState();
}

class _WebDashBoardState extends State<WebDashBoard> {
  List<String> tracks = [];
  List<String> artists = [];
  List<String> songLinks = [];

  _fetchTracksList() async {
    var returned = await SpotifyService()
        .spotify
        .playlists
        //passing in my best playlist id
        .getTracksByPlaylistId(SpotifyService().desiredPlaylistid)
        .all();

    //add returned stuff to lists
    for (var track in returned) {
      var artist = track.artists!.first.name.toString();
      var song = track.name.toString();
      var link = track.uri.toString();

      //update state
      setState(() {
        tracks.add(song);
        artists.add(artist);
        songLinks.add(link);
      });
    }
  }

  @override
  void initState() {
    _fetchTracksList();
    fetchGitUser();
    fetchRedditInfo();
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
                  //dasboard column
                  _dashboardbody(),
                  SizedBox(width: MediaQuery.of(context).size.width / 20),
                ],
              );
            } else {
              return Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width / 5),
                  //dasboard column
                  _dashboardbody(),
                  SizedBox(width: MediaQuery.of(context).size.width / 5),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  _dashboardbody() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.11),
          _topText(),
          const SizedBox(height: 20),
          _socialsSection(),
          const SizedBox(height: 30),
          _skills(),
          const SizedBox(height: 30),
          _trackSection(),
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
                Text(
                  "DashBoard",
                  style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "This is a personal dashboard, built with Flutter. Design inspired by 'leerob', basically for keeping track on my different social platforms, such as my Spotify account, ie fetching my favourite playlist and songs. And preaty much anything else i can think about.",
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

  _socialsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Social",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 4),
            Flexible(
              child: ChipContainer(
                text: "More on the way",
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        ResponsiveWidget(
          mobile: _socialMobileView(),
          webview: _webMobileView(),
        ),
      ],
    );
  }

  _socialMobileView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: redditSection(),
            ),
            // Flexible(
            //   child: _githubSection(),
            // ),
          ],
        ),
      ],
    );
  }

  _webMobileView() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: redditSection(),
        ),
        // Flexible(
        //   child: _githubSection(),
        // ),
        // Flexible(
        //   child: _deviceSection(),
        // ),
      ],
    );
  }

  // _deviceSection() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: [
  //       const SocialImageCard(
  //         image: "assets/images/op6_front.png",
  //         boxFit: BoxFit.scaleDown,
  //       ),
  //       const SizedBox(height: 8),
  //       const Padding(
  //         padding: EdgeInsets.all(8.0),
  //         child: Text(
  //           "Device: OnePlus 6",
  //           style: TextStyle(
  //             fontSize: 16,
  //             fontWeight: FontWeight.w500,
  //           ),
  //         ),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
  //         child: Row(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: const [
  //             Flexible(
  //               child: Text(
  //                 "Os: Oxygen OS 11",
  //                 style: TextStyle(
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.w500,
  //                   color: Colors.white38,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  redditSection() {
    return FutureBuilder(
        future: fetchRedditInfo(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            var redditUserName = snapshot.data!.name;
            var karma = snapshot.data!.totalKarma;
            var avatarImage = snapshot.data!.snoovatarImg;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //alternatively set an image link under constants eg Constants.redditAvatarLink
                SocialImageCard(image: avatarImage as String),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Reddit: $redditUserName",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          "Total Karma : $karma",
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.white38,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox(height: 25, child: Loader());
          }
        });
  }

  // ignore: unused_element
  _githubSection() {
    return FutureBuilder(
        future: fetchGitUser(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            //lateinitializererror with avatarUrl
            //TODO: Update manualy
            //var avatarUrl = snapshot.data!.avatarUrl;

            var githubUserName = snapshot.data!.name;
            var folowers = snapshot.data!.followers;
            var publicRepos = snapshot.data!.publicRepos;
            var following = snapshot.data!.following;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // const SocialImageCard(
                //     image:
                //         "https://raw.githubusercontent.com/Anslem27/Anslem27.github.io/main/assets/assets/images/git_image.jpg"),
                // const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Github: $githubUserName${27}",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              "Followers : $folowers",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white38,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              "Following : $following",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white38,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Flexible(
                          child: Text(
                            "Public Repos : $publicRepos",
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.white38,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox(height: 25, child: Loader());
          }
        });
  }

  _trackSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "My Tracks",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Image.asset("assets/icons/spotify.png", height: 25, width: 25),
                const Padding(
                  padding: EdgeInsets.only(left: 5.0),
                  child: ChipContainer(
                    text: "Updated Daily",
                    color: Colors.greenAccent,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            "Want to check out what am jamming to, here are my daily tracks, fetched directly using the spotify API.",
            maxLines: 2,
            textAlign: TextAlign.start,
            style: GoogleFonts.ubuntu(
              color: Colors.white38,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 20),
        //list of songs from playlist
        ListView.builder(
          shrinkWrap: true,
          //display only first 10 songs
          itemCount: tracks.take(10).length,
          itemBuilder: (_, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Text(
                    "${index + 1}",
                    style: const TextStyle(
                      color: Colors.white30,
                    ),
                  ),
                  title: Text(tracks[index]),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: Text(
                      artists[index],
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  onTap: () {
                    js.context.callMethod('open', [songLinks[index]]);
                  },
                ),
                const SizedBox(height: 8),
                const Divider()
              ],
            );
          },
        ),
      ],
    );
  }

/* Describe more about your skills and proficiency here */

  _skills() {
    return LayoutBuilder(builder: (_, constraints) {
      if (constraints.maxWidth < 600) {
        return _mobileProficiency();
      } else {
        return _webProficiency();
      }
    });
  }

  _mobileProficiency() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset("assets/images/skill.gif", height: 340),
        const Text(
          "Proficiency",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "⚡ Mobile App frontEnd development, very interactive to say the very least. IOS & Android. As well as web Apps.",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            style: GoogleFonts.nunitoSans(
              fontSize: 16,
              color: Colors.white38,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "⚡ Integration of third party services in apps, such as API's.",
            textAlign: TextAlign.start,
            style: GoogleFonts.nunitoSans(
              fontSize: 16,
              color: Colors.white38,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "⚡ Quick learner, problem solver. The list is quite infinite. An one last thing am a redditor",
            textAlign: TextAlign.start,
            style: GoogleFonts.nunitoSans(
              fontSize: 16,
              color: Colors.white38,
            ),
          ),
        ),
      ],
    );
  }

  _webProficiency() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Image.asset("assets/images/skill.gif", height: 340)),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Proficiency",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 4),
                    Flexible(
                      child: ChipContainer(
                        text: "✔",
                        color: Colors.greenAccent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 3.0, right: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(Constants.proficiencyIcons1.length,
                        (index) {
                      return Image.asset(
                        Constants.proficiencyIcons1[index],
                        height: 40,
                      );
                    }),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(Constants.proficiencyIcons2.length,
                      (index) {
                    return Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.asset(
                        Constants.proficiencyIcons2[index],
                        height: 30,
                      ),
                    );
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "⚡ Mobile App frontEnd development, very interactive to say the very least. IOS & Android. As well as web Apps.",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.ubuntu(
                      fontSize: 16,
                      color: Colors.white38,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "⚡ Integration of third party services in apps, such as API's.",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.ubuntu(
                      fontSize: 16,
                      color: Colors.white38,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "⚡ Quick learner, problem solver. The list is quite infinite. An one last thing am a redditor",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.ubuntu(
                      fontSize: 16,
                      color: Colors.white38,
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
}
