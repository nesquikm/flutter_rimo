import 'package:bloc_test/bloc_test.dart';
import 'package:entities_repository/entities_repository.dart';
import 'package:flutter_rimo/pages/locations/bloc/locations_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/helpers.dart';

class MockEntitiesRepository extends Mock implements EntitiesRepository {}

class MockApiLocation extends Mock implements ApiLocation {}

class FakeLocation extends Fake implements Location {}

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

  final mockLocations = [
    mockLocation,
    mockLocation,
    mockLocation,
  ];

  final mockPageLocation = PageLocation(
    entities: mockLocations,
    info: const Info(count: 2, pages: 3, next: null, prev: null),
  );

  group('LocationsBloc', () {
    late MockEntitiesRepository entitiesRepository;
    late ApiLocation mockApiLocation;

    setUpAll(() {
      registerFallbackValue(FakeLocation());
    });

    setUp(() {
      mockApiLocation = MockApiLocation();
      when(
        () => mockApiLocation.getAllLocations(),
      ).thenAnswer((_) => Future<PageLocation>(() => mockPageLocation));

      entitiesRepository = MockEntitiesRepository();
      when(
        () => entitiesRepository.apiLocation,
      ).thenAnswer((_) => mockApiLocation);
    });

    LocationsBloc buildBlocMocked() {
      LocationsBloc? block;
      mockHydratedStorage(() {
        block = LocationsBloc(entitiesRepository);
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
          equals(LocationsInitial()),
        );
      });

      test('toJson/fromJson works properly', () async {
        expect(
          buildBlocMocked().fromJson(
            buildBlocMocked().toJson(
              const LocationsState(),
            ),
          ),
          equals(const LocationsState()),
        );
      });
    });

    blocTest<LocationsBloc, LocationsState>(
      'emits state with updated status',
      build: buildBlocMocked,
      act: (bloc) => bloc.add(LocationsReset()),
      expect: () => [
        const LocationsState(
          status: LocationsStatus.loading,
        ),
      ],
    );

    blocTest<LocationsBloc, LocationsState>(
      'emits state with failure status',
      setUp: () {
        when(
          () => mockApiLocation.getAllLocations(),
        ).thenAnswer((_) => throw ApiLocationFailure());
      },
      build: buildBlocMocked,
      act: (bloc) => bloc.add(LocationsFetchFirstPage()),
      expect: () => [
        const LocationsState(status: LocationsStatus.loading),
        const LocationsState(status: LocationsStatus.failure),
      ],
    );

    group('LocationsFetchNextPage', () {
      blocTest<LocationsBloc, LocationsState>(
        'loads page',
        build: buildBlocMocked,
        seed: LocationsState.new,
        act: (bloc) => bloc.add(const LocationsFetchNextPage()),
        verify: (_) {
          verify(
            () => entitiesRepository.apiLocation.getAllLocations(),
          ).called(1);
        },
      );
    });
  });
}
