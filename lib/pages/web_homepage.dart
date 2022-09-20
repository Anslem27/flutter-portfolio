import 'package:flutter/material.dart';
import 'package:flutter_portfolio/utils/constants.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';

import '../animations/on_hover.dart';
import '../data/data.dart';
import '../models/git_model.dart';
import '../services/repo_fetchservice.dart';
import '../widgets/featured_card.dart';

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
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          SizedBox(width: MediaQuery.of(context).size.width / 5),
          //homepage column
          _body(),
          SizedBox(width: MediaQuery.of(context).size.width / 5),
        ],
      ),
    );
  }

  _body() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.11),
          _initialDescription(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.09),
          _featuredCreations(),
          const SizedBox(height: 20),
          _currentWorks(),
        ],
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
                  style: GoogleFonts.lora(
                    fontWeight: FontWeight.bold,
                    fontSize: 45,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    Constants.description,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.lora(
                      color: Colors.white38,
                      fontSize: 17,
                    ),
                  ),
                ),
                Text(
                  Constants.moreDescription,
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  style: GoogleFonts.lora(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
        //developer image
        CircleAvatar(
          radius: 55,
          backgroundImage: AssetImage(Constants.image),
        )
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
          "Featured Creations",
          style: GoogleFonts.lora(fontSize: 22, fontWeight: FontWeight.w500),
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
                onTap: () {},
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
    double boxSize =
        MediaQuery.of(context).size.height > MediaQuery.of(context).size.width
            ? MediaQuery.of(context).size.width / 2
            : MediaQuery.of(context).size.height / 2.5;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Current Repositories",
          style: GoogleFonts.lora(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        GlassmorphicContainer(
          height: boxSize - 50,
          width: double.maxFinite,
          borderRadius: 10,
          blur: 100,
          alignment: Alignment.bottomCenter,
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
                1,
              ]),
          borderGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFffffff).withOpacity(0.8),
              const Color((0xFFFFFFFF)).withOpacity(0.8),
            ],
          ),
          child: SizedBox(
            height: boxSize - 50,
            child: Padding(
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
                          stargazersCount:
                              snapshot.data!.repo![i].stargazersCount,
                          description: snapshot.data!.repo![i].description,
                        ),
                      );
                    }
                    return ListView(
                      children: repo
                          .take(5)
                          .map(
                            (e) => ListTile(
                                title: Text(
                                  e.name.toString(),
                                ),
                                subtitle: Text(
                                  e.description.toString() == "null"
                                      ? "No description"
                                      : e.description.toString(),
                                ),
                                leading: Text(),
                                trailing: OnHover(builder: (isHovered) {
                                  return OutlinedButton.icon(
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.all(5),
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {},
                                    icon: const Icon(
                                        Icons.open_in_browser_outlined,
                                        color: Colors.white),
                                    label: const Text(
                                      "Read more",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                })),
                          )
                          .toList(),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('Failed to fetch contents'),
                    );
                  } else {
                    //circular indicator
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
