import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'character.g.dart';

/// A chacacter status
enum CharacterStatus {
  @JsonValue('Alive')
  alive,
  @JsonValue('Dead')
  dead,
  @JsonValue('unknown')
  unknown,
}

/// A chacacter gender
enum CharacterGender {
  @JsonValue('Female')
  female,
  @JsonValue('Male')
  male,
  @JsonValue('Genderless')
  genderless,
  @JsonValue('unknown')
  unknown,
}

/// A class for location linking
@JsonSerializable()
class CharacterLocation extends Equatable {
  /// Create explicit character location
  const CharacterLocation({
    required this.name,
    required this.url,
  });

  /// Create character location from json
  factory CharacterLocation.fromJson(Map<String, dynamic> json) =>
      _$CharacterLocationFromJson(json);

  /// The name of the location.
  final String name;

  /// The name of the location.
  final String url;

  @override
  List<Object> get props => [
        name,
        url,
      ];
}

/// A character class
@JsonSerializable()
class Character extends Equatable {
  /// Create explicit character
  const Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  /// Create character location from json
  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);

  /// The id of the character.
  final int id;

  /// The name of the character.
  final String name;

  /// The status of the character (CharacterStatus)
  final CharacterStatus status;

  /// The species of the character.
  final String species;

  /// The type or subspecies of the character.
  final String type;

  /// The gender of the character (CharacterGender)
  final CharacterGender gender;

  /// Name and link to the character's origin location.
  final CharacterLocation origin;

  /// Name and link to the character's last known location endpoint.
  final CharacterLocation location;

  /// Link to the character's image. All images are 300x300px and most are
  /// medium shots or portraits since they are intended to be used as avatars.
  final String image;

  ///List of episodes in which this character appeared.
  final List<String> episode;

  /// Link to the character's own URL endpoint.
  final String url;

  ///Time at which the character was created in the database.
  final DateTime created;

  @override
  List<Object> get props => [
        id,
        name,
        status,
        species,
        type,
        gender,
        origin,
        location,
        image,
        episode,
        url,
        created,
      ];
}
