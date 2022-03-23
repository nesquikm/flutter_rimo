// ignore_for_file: prefer_const_constructors

import 'package:flutter_rimo/pages/episodes/bloc/episodes_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EpisodesEvent', () {
    group('EpisodesReset', () {
      test('supports value equality', () {
        expect(
          EpisodesReset(),
          equals(EpisodesReset()),
        );
      });

      test('props are correct', () {
        expect(
          EpisodesReset().props,
          equals(<Object?>[]),
        );
      });
    });

    group('EpisodesFetchNextPage', () {
      test('supports value equality', () {
        expect(
          EpisodesFetchNextPage(
            reset: true,
          ),
          equals(
            EpisodesFetchNextPage(
              reset: true,
            ),
          ),
        );
      });

      test('props are correct', () {
        expect(
          EpisodesFetchNextPage(
            reset: true,
          ).props,
          equals(<Object?>[
            true, // reset
          ]),
        );
      });
    });
  });
}
