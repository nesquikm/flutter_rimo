// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values

import 'package:entities_repository/entities_repository.dart';
import 'package:flutter_rimo/pages/episodes/bloc/episodes_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

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

  final mockLastPage = PageEpisode(
    entities: [mockEpisode],
    info: Info(count: 2, pages: 3, next: null, prev: null),
  );

  final mockEpisodes = [mockEpisode];

  group('EpisodesState', () {
    EpisodesState createState({
      EpisodesStatus status = EpisodesStatus.initial,
      List<Episode>? episodes,
      final PageEpisode? lastPage,
    }) {
      return EpisodesState(
        status: status,
        episodes: episodes ?? mockEpisodes,
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
          status: EpisodesStatus.initial,
          episodes: mockEpisodes,
          lastPage: null,
        ).props,
        equals(<Object?>[
          null, // lastPage
          EpisodesStatus.initial, // status
          mockEpisodes, // episodes
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
            episodes: null,
            lastPage: null,
          ),
          equals(createState()),
        );
      });

      test('replaces every non-null parameter', () {
        expect(
          createState().copyWith(
            status: EpisodesStatus.success,
            episodes: [],
            lastPage: mockLastPage,
          ),
          equals(
            createState(
              status: EpisodesStatus.success,
              episodes: [],
              lastPage: mockLastPage,
            ),
          ),
        );
      });
    });
  });
}
