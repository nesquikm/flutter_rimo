import 'package:bloc_test/bloc_test.dart';
import 'package:entities_repository/entities_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rimo/pages/locations/bloc/locations_bloc.dart';
import 'package:flutter_rimo/pages/locations/view/location_view.dart';
import 'package:flutter_rimo/pages/locations/view/locations_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../helpers/helpers.dart';

class MockLocationsBloc extends MockBloc<LocationsEvent, LocationsState>
    implements LocationsBloc {}

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

  final mockLocations = [mockLocation, mockLocation, mockLocation];

  group('LocationsView with 3 LocationView', () {
    late LocationsBloc locationsBloc;

    setUp(() {
      locationsBloc = MockLocationsBloc();
      when(() => locationsBloc.state).thenReturn(
        LocationsState(
          status: LocationsStatus.success,
          locations: mockLocations,
        ),
      );
    });

    Widget buildWidget() {
      return BlocProvider.value(
        value: locationsBloc,
        child: const LocationsView(),
      );
    }

    testWidgets('is rendered', (tester) async {
      await mockNetworkImagesFor(
        () => tester.pumpApp(buildWidget()),
      );

      expect(find.byType(LocationsView), findsOneWidget);
    });

    testWidgets('renders AppBar with title text', (tester) async {
      await mockNetworkImagesFor(
        () => tester.pumpApp(buildWidget()),
      );
      expect(find.byType(AppBar), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(AppBar),
          matching: find.text(l10n.appBarTitleLocations),
        ),
        findsOneWidget,
      );
    });

    testWidgets('3 LocationView is rendered', (tester) async {
      await mockNetworkImagesFor(
        () => tester.pumpApp(buildWidget()),
      );
      expect(find.byType(LocationView), findsNWidgets(3));
    });
  });

  group('LocationsView initial state', () {
    late LocationsBloc locationsBloc;

    setUp(() {
      locationsBloc = MockLocationsBloc();
      when(() => locationsBloc.state).thenReturn(
        const LocationsState(),
      );
    });

    Widget buildWidget() {
      return BlocProvider.value(
        value: locationsBloc,
        child: const LocationsView(),
      );
    }

    testWidgets('is rendered', (tester) async {
      await mockNetworkImagesFor(
        () => tester.pumpApp(buildWidget()),
      );

      expect(find.byType(LocationsView), findsOneWidget);
    });

    testWidgets('0 LocationView is rendered', (tester) async {
      await mockNetworkImagesFor(
        () => tester.pumpApp(buildWidget()),
      );
      expect(find.byType(LocationView), findsNothing);
    });

    testWidgets('CircularProgressIndicator is rendered', (tester) async {
      await mockNetworkImagesFor(
        () => tester.pumpApp(buildWidget()),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });

  group('LocationsView in failure status', () {
    late LocationsBloc locationsBloc;

    setUp(() {
      locationsBloc = MockLocationsBloc();
      when(() => locationsBloc.state).thenReturn(
        const LocationsState(status: LocationsStatus.failure),
      );
    });

    Widget buildWidget() {
      return BlocProvider.value(
        value: locationsBloc,
        child: const LocationsView(),
      );
    }

    testWidgets('is rendered', (tester) async {
      await mockNetworkImagesFor(
        () => tester.pumpApp(buildWidget()),
      );

      expect(find.byType(LocationsView), findsOneWidget);
    });

    testWidgets('error is rendered', (tester) async {
      await mockNetworkImagesFor(
        () => tester.pumpApp(buildWidget()),
      );
      expect(find.text(l10n.locationsErrorSnackbarText), findsOneWidget);
    });
  });
}
