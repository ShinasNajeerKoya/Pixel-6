class MovieModel {
  String? poster;
  String? title;
  String? genre;
  List<String>? director;
  List<String>? stars;
  int? runTime;
  String? language;
  int? pageViews;
  int? totalVoted;

  MovieModel({
    this.poster,
    this.title,
    this.genre,
    this.director,
    this.stars,
    this.runTime,
    this.language,
    this.pageViews,
    this.totalVoted,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      poster: json['poster'],
      title: json['title'],
      genre: json['genre'],
      director: json['director'] != null ? List<String>.from(json['director']) : null,
      stars: json['stars'] != null ? List<String>.from(json['stars']) : null,
      runTime: json['runTime'],
      language: json['language'],
      pageViews: json['pageViews'],
      totalVoted: json['totalVoted'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['poster'] = this.poster;
    data['title'] = this.title;
    data['genre'] = this.genre;
    data['director'] = this.director;
    data['stars'] = this.stars;
    data['runTime'] = this.runTime;
    data['language'] = this.language;
    data['pageViews'] = this.pageViews;
    data['totalVoted'] = this.totalVoted;
    return data;
  }
}
