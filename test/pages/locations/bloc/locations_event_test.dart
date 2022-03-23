// ignore_for_file: prefer_const_constructors

import 'package:flutter_rimo/pages/locations/bloc/locations_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LocationsEvent', () {
    group('LocationsReset', () {
      test('supports value equality', () {
        expect(
          LocationsReset(),
          equals(LocationsReset()),
        );
      });

      test('props are correct', () {
        expect(
          LocationsReset().props,
          equals(<Object?>[]),
        );
      });
    });

    group('LocationsFetchNextPage', () {
      test('supports value equality', () {
        expect(
          LocationsFetchNextPage(
            reset: true,
          ),
          equals(
            LocationsFetchNextPage(
              reset: true,
            ),
          ),
        );
      });

      test('props are correct', () {
        expect(
          LocationsFetchNextPage(
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
