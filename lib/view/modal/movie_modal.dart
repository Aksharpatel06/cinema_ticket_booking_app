class MovieModal {
  final String movieName;
  final String type;
  final double imdb;
  final double kino;
  final String description;
  final String certificate;
  final String runtime;
  final int release;
  final String genre;
  final String director;
  final String cast;

  MovieModal._({
    required this.movieName,
    required this.type,
    required this.imdb,
    required this.kino,
    required this.description,
    required this.certificate,
    required this.runtime,
    required this.release,
    required this.genre,
    required this.director,
    required this.cast,
  });

  factory MovieModal(Map json) {
    return MovieModal._(
      movieName: json["movie_name"],
      type: json["type"],
      imdb: json["Imdb"],
      kino: json["Kino"],
      description: json["description"],
      certificate: json["certificate"],
      runtime: json["runtime"],
      release: json["release"],
      genre: json["Genre"],
      director: json["Director"],
      cast: json["Cast"],
    );
  }
}
