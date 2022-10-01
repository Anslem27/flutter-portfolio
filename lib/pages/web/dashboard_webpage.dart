// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:flutter_portfolio/services/spotify_service.dart';
import 'package:flutter_portfolio/widgets/loader.dart';
import 'package:flutter_portfolio/widgets/responsive_layout.dart';
import 'package:flutter_portfolio/widgets/reusable/chip_text.dart';
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
  List<String> tracks = <String>[];
  List<String> artists = <String>[];
  List<String> songLinks = <String>[];

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
                  style: GoogleFonts.lora(
                    fontWeight: FontWeight.bold,
                    fontSize: 45,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "This is a personal dashboard, built with pure dart. Design inspired by 'leerob', basically for keeping track on my different social platforms, such as my Spotify account, ie fetching my favourite playlist and songs. And planning to add more contents with time.",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.lora(
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
        const Text(
          "Social",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
            Flexible(
              child: _githubSection(),
            ),
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
        Flexible(
          child: _githubSection(),
        ),
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
            //todo: make image load faster maybe use a cached network image
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
                    text: "Updated Weekly",
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
            "Want to check out what am jamming to, here are my daily tracks, updated according to my mood.",
            maxLines: 2,
            textAlign: TextAlign.start,
            style: GoogleFonts.roboto(
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
}
