// ignore_for_file: prefer_void_to_null

class Repo {
  String? name;
  String? htmlUrl; //html_url
  int? stargazersCount; //stargazers_count
  String? description;

  Repo({this.name, this.htmlUrl, this.stargazersCount, this.description});

  factory Repo.fromJson(Map<String, dynamic> json) {
    return Repo(
      name: json['name'],
      htmlUrl: json['html_url'],
      stargazersCount: json['stargazers_count'],
      description: json['description'],
    );
  }
}

class AllRepos {
  List<Repo>? repo;
  AllRepos({this.repo});

  factory AllRepos.fromJson(List<dynamic> json) {
    List<Repo> repos = <Repo>[];
    repos = json.map((e) => Repo.fromJson(e)).toList();
    return AllRepos(repo: repos);
  }
}

class GithubUser {
  GithubUser({
    required this.avatarUrl,
    required this.url,
    required this.htmlUrl,
    required this.followersUrl,
    required this.followingUrl,
    required this.starredUrl,
    required this.name,
    this.company,
    required this.blog,
    this.location,
    this.email,
    this.bio,
    required this.twitterUsername,
    required this.publicRepos,
    required this.followers,
    required this.following,
    required this.createdAt,
  });

  late final String avatarUrl;
  late final String url;
  late final String htmlUrl;
  late final String followersUrl;
  late final String followingUrl;
  late final String starredUrl;
  late final String reposUrl;
  late final String name;
  late final Null company;
  late final String blog;
  late final Null location;
  late final Null email;
  late final Null bio;
  late final String twitterUsername;
  late final int publicRepos;
  late final int followers;
  late final int following;
  late final String createdAt;

  GithubUser.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    htmlUrl = json['html_url'];
    followersUrl = json['followers_url'];
    followingUrl = json['following_url'];
    starredUrl = json['starred_url'];
    reposUrl = json['repos_url'];
    name = json['name'];
    company = null;
    blog = json['blog'];
    location = null;
    email = null;
    bio = null;
    twitterUsername = json['twitter_username'];
    publicRepos = json['public_repos'];
    followers = json['followers'];
    following = json['following'];
    createdAt = json['created_at'];
  }
}
