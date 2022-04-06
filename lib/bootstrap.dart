// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:developer';

import 'package:df_repository/df_repository.dart';
import 'package:entities_repository/entities_repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rimo/app/app.dart';
import 'package:flutter_services_binding/flutter_services_binding.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

// class AppBlocObserver extends BlocObserver {
//   @override
//   void onChange(BlocBase bloc, Change change) {
//     super.onChange(bloc, change);
//     log('onChange(${bloc.runtimeType}, $change)');
//   }

//   @override
//   void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
//     log('onError(${bloc.runtimeType}, $error, $stackTrace)');
//     super.onError(bloc, error, stackTrace);
//   }
// }

Future<void> bootstrap() async {
  // FlutterError.onError = (details) {
  //   log(details.exceptionAsString(), stackTrace: details.stack);
  // };

  // TODO(nesquikm):
  // https://github.com/felangel/bloc/issues/3244
  // https://github.com/flutter/flutter/issues/93676
  // WidgetsFlutterBinding.ensureInitialized();
  FlutterServicesBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  final serviceAccountJson =
      await rootBundle.loadString('assets/rimorse2-xphn-b74dc6b8345f.json');
  final entitiesRepository = EntitiesRepository();
  final dfRepository = DfRepository(
    serviceAccountJson: serviceAccountJson,
    project: 'rimorse2-xphn',
  );

  HydratedBlocOverrides.runZoned(
    () => runApp(
      App(
        entitiesRepository: entitiesRepository,
        dfRepository: dfRepository,
      ),
    ),
    // blocObserver: AppBlocObserver(),
    storage: storage,
  );
}
