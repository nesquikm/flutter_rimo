// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter_rimo/home/home.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  group('HomeCubit', () {
    test('initial state is correct', () {
      mockHydratedStorage(() {
        final homeCubit = HomeCubit();
        expect(homeCubit.state, const HomeState(HomeTab.character));
      });
    });
  });

  group('toJson/fromJson', () {
    test('work properly', () {
      mockHydratedStorage(() {
        final homeCubit = HomeCubit();
        expect(
          homeCubit.fromJson(homeCubit.toJson(homeCubit.state)),
          homeCubit.state,
        );
      });
    });
  });

  group('emit setTab', () {
    test('work properly', () {
      mockHydratedStorage(() {
        final homeCubit = HomeCubit();
        expect(homeCubit.state, const HomeState(HomeTab.character));
        homeCubit.setTab(HomeTab.location);
        expect(homeCubit.state, const HomeState(HomeTab.location));
        homeCubit.setTab(HomeTab.episode);
        expect(homeCubit.state, const HomeState(HomeTab.episode));
      });
    });
  });
}
