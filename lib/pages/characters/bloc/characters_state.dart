part of 'characters_bloc.dart';

enum CharactersStatus { initial, success, failure }

@JsonSerializable()
class CharactersState extends Equatable {
  const CharactersState({
    this.status = CharactersStatus.initial,
    this.characters = const <Character>[],
    this.lastPage,
  });

  @override
  factory CharactersState.fromJson(Map<String, dynamic> json) =>
      _$CharactersStateFromJson(json);

  Map<String, dynamic> toJson() => _$CharactersStateToJson(this);

  final PageCharacter? lastPage;

  final CharactersStatus status;
  final List<Character> characters;
  bool get fetchedAll => lastPage != null && lastPage?.info.next == null;

  CharactersState copyWith({
    CharactersStatus? status,
    List<Character>? characters,
    PageCharacter? lastPage,
  }) {
    return CharactersState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
      lastPage: lastPage ?? this.lastPage,
    );
  }

  @override
  List<Object?> get props => [lastPage, status, characters];
}

class CharactersInitial extends CharactersState {}
