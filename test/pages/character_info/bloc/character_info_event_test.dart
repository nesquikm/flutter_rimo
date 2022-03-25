// ignore_for_file: prefer_const_constructors

import 'package:flutter_rimo/pages/character_info/bloc/character_info_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CharacterInfoEvent', () {
    group('CharacterInfoReset', () {
      test('supports value equality', () {
        expect(
          CharacterInfoRefresh(),
          equals(CharacterInfoRefresh()),
        );
      });

      test('props are correct', () {
        expect(
          CharacterInfoRefresh().props,
          equals(<Object?>[]),
        );
      });
    });

    group('CharacterInfoFetchById', () {
      test('supports value equality', () {
        expect(
          CharacterInfoFetchById(
            id: 42,
            refresh: true,
          ),
          equals(
            CharacterInfoFetchById(
              id: 42,
              refresh: true,
            ),
          ),
        );
      });

      test('props are correct', () {
        expect(
          CharacterInfoFetchById(
            id: 42,
            refresh: true,
          ).props,
          equals(<Object?>[
            42, // id
            true, // reset
          ]),
        );
      });
    });
  });
}
