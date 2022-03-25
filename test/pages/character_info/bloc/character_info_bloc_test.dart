import 'package:bloc_test/bloc_test.dart';
import 'package:entities_repository/entities_repository.dart';
import 'package:flutter_rimo/pages/characters/bloc/characters_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/helpers.dart';

class FakeCharacter extends Fake implements Character {}

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

  final mockCharacters = [
    mockCharacter,
    mockCharacter,
    mockCharacter,
  ];

  final mockPageCharacter = PageCharacter(
    entities: mockCharacters,
    info: const Info(count: 2, pages: 3, next: null, prev: null),
  );

  group('CharactersBloc', () {
    late MockEntitiesRepository entitiesRepository;
    late ApiCharacter mockApiCharacter;

    setUpAll(() {
      registerFallbackValue(FakeCharacter());
    });

    setUp(() {
      mockApiCharacter = MockApiCharacter();
      when(
        () => mockApiCharacter.getAllCharacters(),
      ).thenAnswer((_) => Future<PageCharacter>(() => mockPageCharacter));

      entitiesRepository = MockEntitiesRepository();
      when(
        () => entitiesRepository.apiCharacter,
      ).thenAnswer((_) => mockApiCharacter);
    });

    CharactersBloc buildBlocMocked() {
      CharactersBloc? block;
      mockHydratedStorage(() {
        block = CharactersBloc(entitiesRepository);
      });
      return block!;
    }

    group('constructor', () {
      test('works properly', () async {
        expect(buildBlocMocked, returnsNormally);
      });

      test('has correct initial state', () async {
        expect(
          buildBlocMocked().state,
          equals(CharactersInitial()),
        );
      });

      test('toJson/fromJson works properly', () async {
        expect(
          buildBlocMocked().fromJson(
            buildBlocMocked().toJson(
              const CharactersState(),
            ),
          ),
          equals(const CharactersState()),
        );
      });
    });

    blocTest<CharactersBloc, CharactersState>(
      'emits state with updated status',
      build: buildBlocMocked,
      act: (bloc) => bloc.add(CharactersReset()),
      expect: () => [
        const CharactersState(
          status: CharactersStatus.loading,
        ),
      ],
    );

    blocTest<CharactersBloc, CharactersState>(
      'emits state with failure status',
      setUp: () {
        when(
          () => mockApiCharacter.getAllCharacters(),
        ).thenAnswer((_) => throw ApiCharacterFailure());
      },
      build: buildBlocMocked,
      act: (bloc) => bloc.add(CharactersFetchFirstPage()),
      expect: () => [
        const CharactersState(status: CharactersStatus.loading),
        const CharactersState(status: CharactersStatus.failure),
      ],
    );

    group('CharactersFetchNextPage', () {
      blocTest<CharactersBloc, CharactersState>(
        'loads page',
        build: buildBlocMocked,
        seed: CharactersState.new,
        act: (bloc) => bloc.add(const CharactersFetchNextPage()),
        verify: (_) {
          verify(
            () => entitiesRepository.apiCharacter.getAllCharacters(),
          ).called(1);
        },
      );
    });
  });
}
