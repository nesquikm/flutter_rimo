import 'package:bloc_test/bloc_test.dart';
import 'package:entities_repository/entities_repository.dart';
import 'package:flutter_rimo/pages/episodes/bloc/episodes_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/helpers.dart';

class MockEntitiesRepository extends Mock implements EntitiesRepository {}

class MockApiEpisode extends Mock implements ApiEpisode {}

class FakeEpisode extends Fake implements Episode {}

void main() {
  final mockEpisode = Episode(
    id: 1,
    name: 'Pilot',
    airDate: 'December 2, 2013',
    episode: 'S01E01',
    characters: const [
      'https://rickandmortyapi.com/api/character/1',
      'https://rickandmortyapi.com/api/character/2',
    ],
    url: 'https://rickandmortyapi.com/api/episode/1',
    created: DateTime.parse('2017-11-10T12:56:33.798Z'),
  );

  final mockEpisodes = [
    mockEpisode,
    mockEpisode,
    mockEpisode,
  ];

  final mockPageEpisode = PageEpisode(
    entities: mockEpisodes,
    info: const Info(count: 2, pages: 3, next: null, prev: null),
  );

  group('EpisodesBloc', () {
    late MockEntitiesRepository entitiesRepository;
    late ApiEpisode mockApiEpisode;

    setUpAll(() {
      registerFallbackValue(FakeEpisode());
    });

    setUp(() {
      mockApiEpisode = MockApiEpisode();
      when(
        () => mockApiEpisode.getAllEpisodes(),
      ).thenAnswer((_) => Future<PageEpisode>(() => mockPageEpisode));

      entitiesRepository = MockEntitiesRepository();
      when(
        () => entitiesRepository.apiEpisode,
      ).thenAnswer((_) => mockApiEpisode);
    });

    EpisodesBloc buildBlocMocked() {
      EpisodesBloc? block;
      mockHydratedStorage(() {
        block = EpisodesBloc(entitiesRepository);
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
          equals(EpisodesInitial()),
        );
      });

      test('toJson/fromJson works properly', () async {
        expect(
          buildBlocMocked().fromJson(
            buildBlocMocked().toJson(
              const EpisodesState(),
            ),
          ),
          equals(const EpisodesState()),
        );
      });
    });

    blocTest<EpisodesBloc, EpisodesState>(
      'emits state with updated status',
      build: buildBlocMocked,
      act: (bloc) => bloc.add(EpisodesReset()),
      expect: () => [
        const EpisodesState(
          status: EpisodesStatus.loading,
        ),
      ],
    );

    blocTest<EpisodesBloc, EpisodesState>(
      'emits state with failure status',
      setUp: () {
        when(
          () => mockApiEpisode.getAllEpisodes(),
        ).thenAnswer((_) => throw ApiEpisodeFailure());
      },
      build: buildBlocMocked,
      act: (bloc) => bloc.add(EpisodesFetchFirstPage()),
      expect: () => [
        const EpisodesState(status: EpisodesStatus.loading),
        const EpisodesState(status: EpisodesStatus.failure),
      ],
    );

    group('EpisodesFetchNextPage', () {
      blocTest<EpisodesBloc, EpisodesState>(
        'loads page',
        build: buildBlocMocked,
        seed: EpisodesState.new,
        act: (bloc) => bloc.add(const EpisodesFetchNextPage()),
        verify: (_) {
          verify(
            () => entitiesRepository.apiEpisode.getAllEpisodes(),
          ).called(1);
        },
      );
    });
  });
}
