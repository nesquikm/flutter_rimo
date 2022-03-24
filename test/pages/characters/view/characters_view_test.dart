import 'package:bloc_test/bloc_test.dart';
import 'package:entities_repository/entities_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rimo/pages/characters/bloc/characters_bloc.dart';
import 'package:flutter_rimo/pages/characters/view/character_view.dart';
import 'package:flutter_rimo/pages/characters/view/characters_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../helpers/helpers.dart';

class MockCharactersBloc extends MockBloc<CharactersEvent, CharactersState>
    implements CharactersBloc {}

void main() {
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

  final mockCharacters = [mockCharacter, mockCharacter, mockCharacter];

  group('CharactersView with 3 CharacterView', () {
    late CharactersBloc charactersBloc;

    setUp(() {
      charactersBloc = MockCharactersBloc();
      when(() => charactersBloc.state).thenReturn(
        CharactersState(
          status: CharactersStatus.success,
          characters: mockCharacters,
        ),
      );
    });

    Widget buildWidget() {
      return BlocProvider.value(
        value: charactersBloc,
        child: const CharactersView(),
      );
    }

    testWidgets('is rendered', (tester) async {
      await mockNetworkImagesFor(
        () => tester.pumpApp(buildWidget()),
      );

      expect(find.byType(CharactersView), findsOneWidget);
    });

    testWidgets('renders AppBar with title text', (tester) async {
      await mockNetworkImagesFor(
        () => tester.pumpApp(buildWidget()),
      );
      expect(find.byType(AppBar), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(AppBar),
          matching: find.text(l10n.appBarTitleCharacters),
        ),
        findsOneWidget,
      );
    });

    testWidgets('3 CharacterView is rendered', (tester) async {
      await mockNetworkImagesFor(
        () => tester.pumpApp(buildWidget()),
      );
      expect(find.byType(CharacterView), findsNWidgets(3));
    });
  });

  group('CharactersView initial state', () {
    late CharactersBloc charactersBloc;

    setUp(() {
      charactersBloc = MockCharactersBloc();
      when(() => charactersBloc.state).thenReturn(
        const CharactersState(),
      );
    });

    Widget buildWidget() {
      return BlocProvider.value(
        value: charactersBloc,
        child: const CharactersView(),
      );
    }

    testWidgets('is rendered', (tester) async {
      await mockNetworkImagesFor(
        () => tester.pumpApp(buildWidget()),
      );

      expect(find.byType(CharactersView), findsOneWidget);
    });

    testWidgets('0 CharacterView is rendered', (tester) async {
      await mockNetworkImagesFor(
        () => tester.pumpApp(buildWidget()),
      );
      expect(find.byType(CharacterView), findsNothing);
    });

    testWidgets('CircularProgressIndicator is rendered', (tester) async {
      await mockNetworkImagesFor(
        () => tester.pumpApp(buildWidget()),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });

  group('CharactersView in failure status', () {
    late CharactersBloc charactersBloc;

    setUp(() {
      charactersBloc = MockCharactersBloc();
      when(() => charactersBloc.state).thenReturn(
        const CharactersState(status: CharactersStatus.failure),
      );
    });

    Widget buildWidget() {
      return BlocProvider.value(
        value: charactersBloc,
        child: const CharactersView(),
      );
    }

    testWidgets('is rendered', (tester) async {
      await mockNetworkImagesFor(
        () => tester.pumpApp(buildWidget()),
      );

      expect(find.byType(CharactersView), findsOneWidget);
    });

    testWidgets('error is rendered', (tester) async {
      await mockNetworkImagesFor(
        () => tester.pumpApp(buildWidget()),
      );
      expect(find.text(l10n.charactersErrorSnackbarText), findsOneWidget);
    });
  });
}
