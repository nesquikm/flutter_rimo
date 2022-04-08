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
import 'package:flutter_rimo/app/cubit/navigation_cubit.dart';
import 'package:flutter_rimo/app/view/route_parser.dart';
import 'package:flutter_rimo/app/view/router_delegate.dart';
import 'package:flutter_rimo/l10n/l10n.dart';
import 'package:flutter_rimo/pages/pages.dart';

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
      child: BlocProvider(
        create: (_) => NavigationCubit([CharactersPageConfig()]),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _cubit = context.read<NavigationCubit>();
    final _delegate = RIMORouterDelegate(_cubit);
    final _parser = RIMORouteInformationParser();

    return MaterialApp(
      home: Scaffold(
        body: MaterialApp.router(
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.green,
                brightness: Brightness.dark,
              ),
            ),
            routeInformationParser: _parser,
            routerDelegate: _delegate),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _HomeTabButton(
                pageConfig: CharactersPageConfig(),
                icon: Icons.person,
              ),
              _HomeTabButton(
                pageConfig: LocationsPageConfig(),
                icon: Icons.location_pin,
              ),
            ],
          ),
        ),
      ),
    );
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

class _HomeTabButton extends StatelessWidget {
  const _HomeTabButton({
    Key? key,
    required this.pageConfig,
    required this.icon,
  }) : super(key: key);

  final PageConfig pageConfig;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final firstRoute =
        context.select((NavigationCubit cubit) => cubit.state.first);

    final isActive = firstRoute == pageConfig;
    return IconButton(
      onPressed: () => context.read<NavigationCubit>().replace(pageConfig),
      iconSize: 32,
      color: isActive ? Theme.of(context).colorScheme.secondary : null,
      icon: Icon(
        icon,
      ),
    );
  }
}
