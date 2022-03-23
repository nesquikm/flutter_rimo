// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values

import 'package:entities_repository/entities_repository.dart';
import 'package:flutter_rimo/pages/characters/bloc/characters_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final mockCharacter = Character(
    id: 1,
    name: 'Rick Sanchez',
    status: CharacterStatus.alive,
    species: 'Human',
    type: '',
    gender: CharacterGender.male,
    origin: const CharacterLocation(
      name: 'Earth (C-137)',
      url: 'https://rickandmortyapi.com/api/location/1',
    ),
    location: const CharacterLocation(
      name: 'Citadel of Ricks',
      url: 'https://rickandmortyapi.com/api/location/3',
    ),
    image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
    episode: const [
      'https://rickandmortyapi.com/api/episode/1',
      'https://rickandmortyapi.com/api/episode/2',
    ],
    url: 'https://rickandmortyapi.com/api/character/1',
    created: DateTime.parse('2017-11-04T18:48:46.250Z'),
  );

  final mockLastPage = PageCharacter(
    entities: [mockCharacter],
    info: Info(count: 2, pages: 3, next: null, prev: null),
  );

  final mockCharacters = [mockCharacter];

  group('CharactersState', () {
    CharactersState createState({
      CharactersStatus status = CharactersStatus.initial,
      List<Character>? characters,
      final PageCharacter? lastPage,
    }) {
      return CharactersState(
        status: status,
        characters: characters ?? mockCharacters,
        lastPage: lastPage,
      );
    }

    test('supports value equality', () {
      expect(
        createState(),
        equals(createState()),
      );
    });

    test('props are correct', () {
      expect(
        createState(
          status: CharactersStatus.initial,
          characters: mockCharacters,
          lastPage: null,
        ).props,
        equals(<Object?>[
          null, // lastPage
          CharactersStatus.initial, // status
          mockCharacters, // characters
        ]),
      );
    });

    group('copyWith', () {
      test('returns the same object if not arguments are provided', () {
        expect(
          createState().copyWith(),
          equals(createState()),
        );
      });

      test('retains the old value for every parameter if null is provided', () {
        expect(
          createState().copyWith(
            status: null,
            characters: null,
            lastPage: null,
          ),
          equals(createState()),
        );
      });

      test('replaces every non-null parameter', () {
        expect(
          createState().copyWith(
            status: CharactersStatus.success,
            characters: [],
            lastPage: mockLastPage,
          ),
          equals(
            createState(
              status: CharactersStatus.success,
              characters: [],
              lastPage: mockLastPage,
            ),
          ),
        );
      });
    });
  });
}
