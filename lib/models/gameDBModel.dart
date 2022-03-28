final String followedGames = 'games';

class gameFields
{ //field or column names\
  static final List<String> values =
  [
    id, title, developer, publisher, description, ReleaseDate
  ];

  static final String id = '_id';
  static final String title = 'title';
  static final String developer = 'developer';
  static final String publisher = 'publisher';
  static final String description = 'desription';
  static final String ReleaseDate = 'ReleaseDate';
}

class gameDBModel
{
  final int? id;
  final String title;
  final String developer;
  final String publisher;
  final String description;
  final DateTime ReleaseDate;

  const gameDBModel
  ({
  this.id,
  required this.title,
  required this.developer,
  required this.publisher,
  required this.description,
  required this.ReleaseDate,
});

  gameDBModel copy({
    int? id,
    String? title,
    String? developer,
    String? publisher,
    String? description,
    DateTime? ReleaseDate,
}) =>
  gameDBModel(
    id: id ?? this.id,
    title: title ?? this.title,
    developer: developer ?? this.developer,
    publisher: publisher ?? this.publisher,
    description: description ?? this.description,
    ReleaseDate: ReleaseDate ?? this.ReleaseDate,
  );

  static gameDBModel fromJson(Map<String, Object?> json) =>
    gameDBModel(
      id: json[gameFields.id] as int?,
      title: json[gameFields.title] as String,
      developer: json[gameFields.developer] as String,
      publisher: json[gameFields.publisher] as String,
      description: json[gameFields.description] as String,
      ReleaseDate: DateTime.parse([gameFields.ReleaseDate] as String),
    );

  Map<String, Object?> toJson() =>
      {
        gameFields.id: id,
        gameFields.title: title,
        gameFields.developer: developer,
        gameFields.publisher: publisher,
        gameFields.description: description,
        gameFields.ReleaseDate: ReleaseDate.toIso8601String(),
      };
}