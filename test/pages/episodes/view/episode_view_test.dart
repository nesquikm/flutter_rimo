import 'package:entities_repository/entities_repository.dart';
import 'package:flutter_rimo/pages/episodes/view/episode_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('EpisodeView', () {
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

    setUp(() {});

    group('constructor', () {
      test('works properly', () {
        expect(
          () => EpisodeView(episode: mockEpisode),
          returnsNormally,
        );
      });
    });

    group('view', () {
      testWidgets('is rendered', (tester) async {
        await mockNetworkImagesFor(
          () => tester.pumpApp(EpisodeView(episode: mockEpisode)),
        );

        expect(find.text(mockEpisode.name), findsOneWidget);
        expect(
          find.text('${mockEpisode.episode}, ${mockEpisode.airDate}'),
          findsOneWidget,
        );
      });
    });
  });
}
