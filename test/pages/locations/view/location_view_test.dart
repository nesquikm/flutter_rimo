import 'package:entities_repository/entities_repository.dart';
import 'package:flutter_rimo/pages/locations/view/location_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('LocationView', () {
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

    setUp(() {});

    group('constructor', () {
      test('works properly', () {
        expect(
          () => LocationView(location: mockLocation),
          returnsNormally,
        );
      });
    });

    group('view', () {
      testWidgets('is rendered', (tester) async {
        await mockNetworkImagesFor(
          () => tester.pumpApp(LocationView(location: mockLocation)),
        );

        expect(find.text(mockLocation.name), findsOneWidget);
        expect(
          find.text(
            '${mockLocation.type}, dimension: ${mockLocation.dimension}',
          ),
          findsOneWidget,
        );
      });
    });
  });
}
