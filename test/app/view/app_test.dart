// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:entities_repository/entities_repository.dart';
import 'package:flutter_rimo/app/app.dart';
import 'package:flutter_rimo/counter/counter.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  late EntitiesRepository entitiesRepository;
  setUp(() {
    entitiesRepository = MockEntitiesRepository();
  });

  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await mockHydratedStorage(() async {
        await tester.pumpWidget(App(entitiesRepository: entitiesRepository));
      });
      expect(find.byType(CounterPage), findsOneWidget);
    });
  });
}
