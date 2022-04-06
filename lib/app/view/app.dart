// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:df_repository/df_repository.dart';
import 'package:entities_repository/entities_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_rimo/app/view/home_navigator.dart';
import 'package:flutter_rimo/l10n/l10n.dart';
import 'package:flutter_rimo/pages/pages.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_rimo/home/view/view.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.entitiesRepository,
    required this.dfRepository,
  }) : super(key: key);

  final EntitiesRepository entitiesRepository;
  final DfRepository dfRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: entitiesRepository),
        RepositoryProvider.value(value: dfRepository),
      ],
      child: const MaterialApp(home: AppView()),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _router = GoRouter(
      routes: [
        GoRoute(
          path: '/characters',
          name: 'characters',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: CharactersPage(),
          ),
        ),
        // GoRoute(
        //   path: '/locations',
        //   name: 'locations',
        //   pageBuilder: (context, state) => const NoTransitionPage(
        //     child: LocationsPage(),
        //   ),
        // ),
        // GoRoute(
        //   path: '/episodes',
        //   name: 'episodes',
        //   pageBuilder: (context, state) => const NoTransitionPage(
        //     child: EpisodesPage(),
        //   ),
        // ),
        // GoRoute(
        //   path: '/chat',
        //   name: 'chat',
        //   pageBuilder: (context, state) => const NoTransitionPage(
        //     child: ChatPage(),
        //   ),
        // ),
      ],
      // navigatorBuilder: (context, state, child) =>
      // HomeNavigator(context: context, state: state, child: child),
      // redirect: (GoRouterState state) {
      //   if (state.location == '/') return '/characters';
      //   return null;
      // },
      initialLocation: '/characters',
    );

    return MaterialApp.router(
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green,
          brightness: Brightness.dark,
        ),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      // title: title,
    );

    // return MaterialApp(
    //   theme: ThemeData(
    //     colorScheme: ColorScheme.fromSwatch(
    //       primarySwatch: Colors.green,
    //       brightness: Brightness.dark,
    //     ),
    //   ),
    //   localizationsDelegates: const [
    //     AppLocalizations.delegate,
    //     GlobalMaterialLocalizations.delegate,
    //   ],
    //   supportedLocales: AppLocalizations.supportedLocales,
    //   home: k,
    // );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     theme: ThemeData(
  //       colorScheme: ColorScheme.fromSwatch(
  //         primarySwatch: Colors.green,
  //         brightness: Brightness.dark,
  //       ),
  //     ),
  //     localizationsDelegates: const [
  //       AppLocalizations.delegate,
  //       GlobalMaterialLocalizations.delegate,
  //     ],
  //     supportedLocales: AppLocalizations.supportedLocales,
  //     home: const HomePage(),
  //   );
  // }
}
