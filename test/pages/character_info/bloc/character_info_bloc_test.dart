import 'package:bloc_test/bloc_test.dart';
import 'package:entities_repository/entities_repository.dart';
import 'package:flutter_rimo/pages/character_info/bloc/character_info_bloc.dart';
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

  group('CharacterInfoBloc', () {
    late MockEntitiesRepository entitiesRepository;
    late ApiCharacter mockApiCharacter;

    setUpAll(() {
      registerFallbackValue(FakeCharacter());
    });

    setUp(() {
      mockApiCharacter = MockApiCharacter();
      when(() => mockApiCharacter.getListOfCharacters(ids: [42]))
          .thenAnswer((_) => Future<List<Character>>(() => [mockCharacter]));

      entitiesRepository = MockEntitiesRepository();
      when(
        () => entitiesRepository.apiCharacter,
      ).thenAnswer((_) => mockApiCharacter);
    });

    CharacterInfoBloc buildBlocMocked() {
      CharacterInfoBloc? block;
      mockHydratedStorage(() {
        block = CharacterInfoBloc(entitiesRepository);
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
          equals(CharacterInfoInitial()),
        );
      });

      test('toJson/fromJson works properly', () async {
        expect(
          buildBlocMocked().fromJson(
            buildBlocMocked().toJson(
              const CharacterInfoState(),
            ),
          ),
          equals(const CharacterInfoState()),
        );
      });
    });

    blocTest<CharacterInfoBloc, CharacterInfoState>(
      'emits state with updated status',
      build: buildBlocMocked,
      act: (bloc) => bloc.add(const CharacterInfoFetchById(id: 42)),
      expect: () => [
        const CharacterInfoState(
          status: CharacterInfoStatus.loading,
        ),
        CharacterInfoState(
          status: CharacterInfoStatus.success,
          character: mockCharacter,
          characterCache: {42: mockCharacter},
        ),
      ],
    );

    blocTest<CharacterInfoBloc, CharacterInfoState>(
      'emits state with failure status',
      setUp: () {
        when(
          () => mockApiCharacter.getListOfCharacters(ids: [42]),
        ).thenAnswer((_) => throw ApiCharacterFailure());
      },
      build: buildBlocMocked,
      act: (bloc) => bloc.add(const CharacterInfoFetchById(id: 42)),
      expect: () => [
        const CharacterInfoState(status: CharacterInfoStatus.loading),
        const CharacterInfoState(status: CharacterInfoStatus.failure),
      ],
    );

    blocTest<CharacterInfoBloc, CharacterInfoState>(
      'emits state with failure status',
      setUp: () {
        when(
          () => mockApiCharacter.getListOfCharacters(ids: [42]),
        ).thenAnswer((_) => Future<List<Character>>(() => []));
      },
      build: buildBlocMocked,
      act: (bloc) => bloc.add(const CharacterInfoFetchById(id: 42)),
      expect: () => [
        const CharacterInfoState(status: CharacterInfoStatus.loading),
        const CharacterInfoState(status: CharacterInfoStatus.failure),
      ],
    );

    group('CharacterInfoFetchById', () {
      blocTest<CharacterInfoBloc, CharacterInfoState>(
        'loads character',
        build: buildBlocMocked,
        seed: CharacterInfoState.new,
        act: (bloc) => bloc.add(const CharacterInfoFetchById(id: 42)),
        verify: (_) {
          verify(
            () =>
                entitiesRepository.apiCharacter.getListOfCharacters(ids: [42]),
          ).called(1);
        },
      );
    });
  });
}
