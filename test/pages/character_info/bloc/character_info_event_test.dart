// ignore_for_file: prefer_const_constructors

import 'package:flutter_rimo/pages/characters/bloc/characters_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CharactersEvent', () {
    group('CharactersReset', () {
      test('supports value equality', () {
        expect(
          CharactersReset(),
          equals(CharactersReset()),
        );
      });

      test('props are correct', () {
        expect(
          CharactersReset().props,
          equals(<Object?>[]),
        );
      });
    });

    group('CharactersFetchNextPage', () {
      test('supports value equality', () {
        expect(
          CharactersFetchNextPage(
            reset: true,
          ),
          equals(
            CharactersFetchNextPage(
              reset: true,
            ),
          ),
        );
      });

      test('props are correct', () {
        expect(
          CharactersFetchNextPage(
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
