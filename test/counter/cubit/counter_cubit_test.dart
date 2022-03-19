// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter_rimo/counter/counter.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  group('CounterCubit', () {
    test('initial state is correct', () {
      mockHydratedStorage(() {
        final counterCubit = CounterCubit();
        expect(counterCubit.state, const CounterState(count: 0));
      });
    });
  });

  group('toJson/fromJson', () {
    test('work properly', () {
      mockHydratedStorage(() {
        final counterCubit = CounterCubit();
        expect(
          counterCubit.fromJson(counterCubit.toJson(counterCubit.state)),
          counterCubit.state,
        );
      });
    });
  });

  group('emit increment/decrement', () {
    test('work properly', () {
      mockHydratedStorage(() {
        final counterCubit = CounterCubit();
        expect(counterCubit.state, const CounterState(count: 0));
        counterCubit.increment();
        expect(counterCubit.state, const CounterState(count: 1));
        counterCubit.decrement();
        expect(counterCubit.state, const CounterState(count: 0));
      });
    });
  });
}
