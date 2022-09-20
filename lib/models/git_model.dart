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
