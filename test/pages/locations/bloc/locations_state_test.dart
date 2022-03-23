// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values

import 'package:entities_repository/entities_repository.dart';
import 'package:flutter_rimo/pages/locations/bloc/locations_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final mockLocation = Location(
    id: 7,
    name: 'Immortality Field Resort',
    type: 'Resort',
    dimension: 'unknown',
    residents: const [
      'https://rickandmortyapi.com/api/character/23',
      'https://rickandmortyapi.com/api/character/204',
      'https://rickandmortyapi.com/api/character/320',
    ],
    url: 'https://rickandmortyapi.com/api/location/7',
    created: DateTime.parse('2017-11-10T13:09:17.136Z'),
  );

  final mockLastPage = PageLocation(
    entities: [mockLocation],
    info: Info(count: 2, pages: 3, next: null, prev: null),
  );

  final mockLocations = [mockLocation];

  group('LocationsState', () {
    LocationsState createState({
      LocationsStatus status = LocationsStatus.initial,
      List<Location>? locations,
      final PageLocation? lastPage,
    }) {
      return LocationsState(
        status: status,
        locations: locations ?? mockLocations,
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
          status: LocationsStatus.initial,
          locations: mockLocations,
          lastPage: null,
        ).props,
        equals(<Object?>[
          null, // lastPage
          LocationsStatus.initial, // status
          mockLocations, // locations
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
            locations: null,
            lastPage: null,
          ),
          equals(createState()),
        );
      });

      test('replaces every non-null parameter', () {
        expect(
          createState().copyWith(
            status: LocationsStatus.success,
            locations: [],
            lastPage: mockLastPage,
          ),
          equals(
            createState(
              status: LocationsStatus.success,
              locations: [],
              lastPage: mockLastPage,
            ),
          ),
        );
      });
    });
  });
}
