class MovieModel {
  final int id;
  final String title;
  final String overview;
  final String backdropPath;
  final String posterPath;
  final double voteAverage;
  final String releaseDate;
  final List<String> genres;
  final int runtime;
  final List<String> productionCompanies;
  final int budget;
  final int revenue;
  final List<String> spokenLanguages;

  MovieModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.backdropPath,
    required this.posterPath,
    required this.voteAverage,
    required this.releaseDate,
    required this.genres,
    required this.runtime,
    required this.productionCompanies,
    required this.budget,
    required this.revenue,
    required this.spokenLanguages,
  });

  String get posterUrl {
    return 'https://image.tmdb.org/t/p/w500$posterPath';
  }

  String get backdropUrl {
    return 'https://image.tmdb.org/t/p/w500$backdropPath';
  }

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      posterPath: json['poster_path'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      releaseDate: json['release_date'] ?? '',
      genres: (json['genres'] as List<dynamic>?)?.map((genre) => genre['name'].toString()).toList() ?? [],
      runtime: json['runtime'] ?? 0,
      productionCompanies:
          (json['production_companies'] as List<dynamic>?)?.map((company) => company['name'].toString()).toList() ?? [],
      budget: json['budget'] ?? 0,
      revenue: json['revenue'] ?? 0,
      spokenLanguages:
          (json['spoken_languages'] as List<dynamic>?)
              ?.map((language) => language['english_name'].toString())
              .toList() ??
          [],
    );
  }
}
