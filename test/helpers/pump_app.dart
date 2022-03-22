// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:entities_repository/entities_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_rimo/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget) {
    final EntitiesRepository entitiesRepository = MockEntitiesRepository();

    return pumpWidget(
      RepositoryProvider.value(
        value: entitiesRepository,
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: widget,
        ),
      ),
    );
  }
}

class MockEntitiesRepository extends Mock implements EntitiesRepository {
  @override
  ApiCharacter get apiCharacter => MockApiCharacter();
}

class MockApiCharacter extends Mock implements ApiCharacter {
  // @override
  // Future<PageCharacter> getAllCharacters({
  //   ApiCharacterFilters? filters,
  //   PageCharacter? prevPage,
  //   PageCharacter? nextPage,
  // }) async {
  //   return PageCharacter(
  //     entities: [
  //       Character(
  //           id: 1,
  //           name: 'name',
  //           status: CharacterStatus.alive,
  //           species: 'species',
  //           type: 'type',
  //           gender: CharacterGender.female,
  //           origin: CharacterLocation(name: 'name', url: 'url'),
  //           location: CharacterLocation(name: 'name', url: 'url'),
  //           image: 'image',
  //           episode: [],
  //           url: 'url',
  //           created: DateTime.now())
  //     ],
  //     info: Info(count: 2, pages: 3, next: null, prev: null),
  //   );
  // }

  // @override
  // Future<List<Character>> getListOfCharacters({required List<int> ids})
  // async {
  //   return [];
  // }
}
