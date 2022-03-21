part of 'characters_bloc.dart';

enum CharactersStatus { initial, success, failure }

@JsonSerializable()
class CharactersState extends Equatable {
  const CharactersState({
    this.status = CharactersStatus.initial,
    this.characters = const <Character>[],
    this.fetchedAll = false,
  });

  @override
  factory CharactersState.fromJson(Map<String, dynamic> json) =>
      _$CharactersStateFromJson(json);

  Map<String, dynamic> toJson() => _$CharactersStateToJson(this);

  final CharactersStatus status;
  final List<Character> characters;
  final bool fetchedAll;

  CharactersState copyWith({
    CharactersStatus? status,
    List<Character>? characters,
    bool? fetchedAll,
  }) {
    return CharactersState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
      fetchedAll: fetchedAll ?? this.fetchedAll,
    );
  }

  @override
  List<Object> get props => [status, characters, fetchedAll];
}

class CharactersInitial extends CharactersState {}
