import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'episode.g.dart';

/// An episode class
@JsonSerializable()
class Episode extends Equatable {
  /// Create explicit episode
  const Episode({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
    required this.characters,
    required this.url,
    required this.created,
  });

  /// Create episode from json
  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);

  /// The id of the episode.
  final int id;

  /// The name of the episode.
  final String name;

  /// The air date of the episode.
  @JsonKey(name: 'air_date')
  final String airDate;

  /// The code of the episode.
  final String episode;

  /// List of characters who have been seen in the episode.
  final List<String> characters;

  /// Link to the episode's own endpoint.
  final String url;

  /// Time at which the episode was created in the database.
  final DateTime created;

  @override
  List<Object> get props => [
        id,
        name,
        airDate,
        episode,
        characters,
        url,
        created,
      ];
}
