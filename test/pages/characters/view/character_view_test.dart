import 'package:entities_repository/entities_repository.dart';
import 'package:flutter_rimo/pages/characters/view/character_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('CharacterView', () {
    final mockCharacter = Character(
      id: 1,
      name: 'Rick Sanchez',
      status: CharacterStatus.alive,
      species: 'Human',
      type: '',
      gender: CharacterGender.male,
      origin: const CharacterLocation(
        name: 'Earth (C-137)',
        url: 'https://rickandmortyapi.com/api/location/1',
      ),
      location: const CharacterLocation(
        name: 'Citadel of Ricks',
        url: 'https://rickandmortyapi.com/api/location/3',
      ),
      image: '',
      episode: const [
        'https://rickandmortyapi.com/api/episode/1',
        'https://rickandmortyapi.com/api/episode/2',
      ],
      url: 'https://rickandmortyapi.com/api/character/1',
      created: DateTime.parse('2017-11-04T18:48:46.250Z'),
    );

    setUp(() {});

    group('constructor', () {
      test('works properly', () {
        expect(
          () => CharacterView(character: mockCharacter),
          returnsNormally,
        );
      });
    });

    group('view', () {
      testWidgets('is rendered', (tester) async {
        await mockNetworkImagesFor(
          () => tester.pumpApp(CharacterView(character: mockCharacter)),
        );

        expect(find.text(mockCharacter.name), findsOneWidget);
        expect(
          find.text('${mockCharacter.species}, ${mockCharacter.gender.name}'),
          findsOneWidget,
        );
      });
    });
  });
}
