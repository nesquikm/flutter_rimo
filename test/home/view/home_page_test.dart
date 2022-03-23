// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:bloc_test/bloc_test.dart';
// import 'package:entities_repository/entities_repository.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rimo/home/home.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// import '../../helpers/helpers.dart';

class MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {}

void main() {
  group('HomePage', () {
    // testWidgets('renders HomeView', (tester) async {
    //   await mockHydratedStorage(() async {
    //     await tester.pumpApp(const HomePage());
    //   });
    //   expect(find.byType(HomeView), findsOneWidget);
    // });
    // testWidgets('renders HomeView', (tester) async {
    //   await mockHydratedStorage(() async {
    //     // await tester.pumpApp(const HomePage());
    //     await tester.pumpWidget(
    //       RepositoryProvider.value(
    //         value: entitiesRepository,
    //         child: const MaterialApp(
    //           home: HomePage(),
    //         ),
    //       ),
    //     );
    //   });
    //   expect(find.byType(HomeView), findsOneWidget);
    // });
  });

  // group('HomeView', () {
  //   late HomeCubit homeCubit;

  //   setUp(() {
  //     homeCubit = MockHomeCubit();
  //   });

  //   testWidgets('renders current tab', (tester) async {
  //     const state = HomeState(HomeTab.episode);
  //     when(() => homeCubit.state).thenReturn(state);
  //     await tester.pumpApp(
  //       BlocProvider.value(
  //         value: homeCubit,
  //         child: const HomeView(),
  //       ),
  //     );
  //     expect(find.byIcon(Icons.person), findsOneWidget);
  //     expect(find.byIcon(Icons.location_pin), findsOneWidget);
  //     expect(find.byIcon(Icons.list_rounded), findsOneWidget);

  //     expect(
  //       (tester.firstWidget(find.byIcon(Icons.person)) as Icon).color,
  //       isNull,
  //     );
  //     expect(
  //       (tester.firstWidget(find.byIcon(Icons.location_pin)) as Icon).color,
  //       isNull,
  //     );
  //     expect(
  //       (tester.firstWidget(find.byIcon(Icons.list_rounded)) as Icon).color,
  //       isNotNull,
  //     );
  //   });

  //   testWidgets('calls setTab when icon is tapped', (tester) async {
  //     when(() => homeCubit.state)
  //         .thenReturn(const HomeState(HomeTab.character));
  //     when(() => homeCubit.setTab(HomeTab.location)).thenReturn(null);
  //     await tester.pumpApp(
  //       BlocProvider.value(
  //         value: homeCubit,
  //         child: const HomeView(),
  //       ),
  //     );
  //     await tester.tap(find.byIcon(Icons.location_pin));
  //     verify(() => homeCubit.setTab(HomeTab.location)).called(1);
  //   });
  // });
}
