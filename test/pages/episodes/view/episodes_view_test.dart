import 'package:bloc_test/bloc_test.dart';
import 'package:entities_repository/entities_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rimo/pages/episodes/bloc/episodes_bloc.dart';
import 'package:flutter_rimo/pages/episodes/view/episode_view.dart';
import 'package:flutter_rimo/pages/episodes/view/episodes_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../helpers/helpers.dart';

class MockEpisodesBloc extends MockBloc<EpisodesEvent, EpisodesState>
    implements EpisodesBloc {}

void main() {
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

  final mockEpisodes = [mockEpisode, mockEpisode, mockEpisode];

  group('EpisodesView with 3 EpisodeView', () {
    late EpisodesBloc episodesBloc;

    setUp(() {
      episodesBloc = MockEpisodesBloc();
      when(() => episodesBloc.state).thenReturn(
        EpisodesState(
          status: EpisodesStatus.success,
          episodes: mockEpisodes,
        ),
      );
    });

    Widget buildWidget() {
      return BlocProvider.value(
        value: episodesBloc,
        child: const EpisodesView(),
      );
    }

    testWidgets('is rendered', (tester) async {
      await mockNetworkImagesFor(
        () => tester.pumpApp(buildWidget()),
      );

      expect(find.byType(EpisodesView), findsOneWidget);
    });

    testWidgets('renders AppBar with title text', (tester) async {
      await mockNetworkImagesFor(
        () => tester.pumpApp(buildWidget()),
      );
      expect(find.byType(AppBar), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(AppBar),
          matching: find.text(l10n.appBarTitleEpisodes),
        ),
        findsOneWidget,
      );
    });

    testWidgets('3 EpisodeView is rendered', (tester) async {
      await mockNetworkImagesFor(
        () => tester.pumpApp(buildWidget()),
      );
      expect(find.byType(EpisodeView), findsNWidgets(3));
    });
  });

  group('EpisodesView initial state', () {
    late EpisodesBloc episodesBloc;

    setUp(() {
      episodesBloc = MockEpisodesBloc();
      when(() => episodesBloc.state).thenReturn(
        const EpisodesState(),
      );
    });

    Widget buildWidget() {
      return BlocProvider.value(
        value: episodesBloc,
        child: const EpisodesView(),
      );
    }

    testWidgets('is rendered', (tester) async {
      await mockNetworkImagesFor(
        () => tester.pumpApp(buildWidget()),
      );

      expect(find.byType(EpisodesView), findsOneWidget);
    });

    testWidgets('0 EpisodeView is rendered', (tester) async {
      await mockNetworkImagesFor(
        () => tester.pumpApp(buildWidget()),
      );
      expect(find.byType(EpisodeView), findsNothing);
    });

    testWidgets('CircularProgressIndicator is rendered', (tester) async {
      await mockNetworkImagesFor(
        () => tester.pumpApp(buildWidget()),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });

  group('EpisodesView in failure status', () {
    late EpisodesBloc episodesBloc;

    setUp(() {
      episodesBloc = MockEpisodesBloc();
      when(() => episodesBloc.state).thenReturn(
        const EpisodesState(status: EpisodesStatus.failure),
      );
    });

    Widget buildWidget() {
      return BlocProvider.value(
        value: episodesBloc,
        child: const EpisodesView(),
      );
    }

    testWidgets('is rendered', (tester) async {
      await mockNetworkImagesFor(
        () => tester.pumpApp(buildWidget()),
      );

      expect(find.byType(EpisodesView), findsOneWidget);
    });

    testWidgets('error is rendered', (tester) async {
      await mockNetworkImagesFor(
        () => tester.pumpApp(buildWidget()),
      );
      expect(find.text(l10n.episodesErrorSnackbarText), findsOneWidget);
    });
  });
}
