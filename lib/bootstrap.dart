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
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';
import 'package:flutter_rimo/app/app.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

// const serviceAccountJson = r'''
// {
//   "type": "service_account",
//   "project_id": "rimorse2-xphn",
//   "private_key_id": "7759c5c4dbfbb99b18d45f82b44803c39dba3ba0",
//   "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCgdJeRanFTXg27\nOyLWPvntE4suek4sdK50/y1D/Bz28+o4ZQn1J3wcNbXaUUjImGplrZjTvqOdC21J\nV4RNojg4yCv2Z8H7tdJgkYRyEx6KRf59jSIIgc5+NdKVRpOq8DCNN4bL42ZqXppr\ndxFpd619ENfN3nUCPxf1sJfQ9rtMeh3csg7Cgw0vdJL/IWe8732dSTYdq6mVW1Bq\ncZ3G25TTDkqXME0b6Fm289bWX39oaz29a0Xw8V4qi65vLfGjgEV4JQerk3WLQqLX\nr+W0vcXxRv95KCI87uGQF+Q6HgBEYvZEAypVvIaeV+Rj6xTP0VHqofc57uR+vbzy\nvBg3JEoHAgMBAAECggEAR5ju/wyzp8MatnajS12LkR28587cbhrcs8kfrivj0tAx\nLdvsDxAA4eeXj2Tg6N2V8Gv/e1CgWlW8fNMH7spZcwDjGQ7gcMyHpN6Z7nsYkBO+\nhNCCpLAjb47dug1lnAuUZpcl13nPe9xd5GEbjGfCKsHmwe6nYIq9yrxzaeOG3Q8V\ni1/BCTEOfhWThAdnwiRpVYwbyrRvyD90idnne6tKTEOMLgSMhcd3AIFUEeRF+I/5\nUZEX9QOKM1pblux2ghUMIuBJtmgpg/o+2FVxXvUAt9oNki7rlB8ZwsIBjpGrmuq/\nIDZCDV7UFK0tKlVaW4tM3eI2Ods13UOy3/b2TVIaRQKBgQDUgX49VNuB6r0OkoSB\nF35gIszudz8K4ZCCP2IrwI+Vldf8t9QCZmh4swlg0ekQ0PW/znUJi5Jrja+I05DM\n4lZYZ3HYonVu3qZ6h0Zqa9qY7P9dLc6fLm+e+BbCGhAQSGo88vcWhyi1zjRVL7oQ\njCSv6GlfLuyM+N9nkjAzApqYfQKBgQDBS9qY5jpeyIfmCSZTDDIe+K0SeZ1Rqi65\n71GP43UlWFwhjex1RLmlCpVlnV8d4EWB6Wz4wbIiyHNMvZMo/tlTRjFCXgdSsqcD\nm4hdO5qsSgnp+rzeVKjVlJaHGBlwU7ynK3QrezIhGd9OIVx83alhqQHtl3gNPYmO\nyPQVhnj30wKBgC9rNeA5r0GuP8GgsDCeLXUGTvRnZ4nmC3kE68MXlPKsHSYnXweq\nEmXcjZstO/SkrDHAwB0BKAsX8rN1gjo1x06yxpSwq8OxqzRsOypEJuM4/0Krlg+v\nLPksIuftKOh5QDuZe8lrH4pyGPtpSvumSgl2swyqS96pKjDSTi8TxauBAoGAOk3f\nCe+n+58RHtnzrWkoVR89VS1JvrBOl9cQCw7Y7wLQB27/u/+W36lpltT5M9HKJX17\nWS1TxhogbS1hjiQQ+YVapmImY1Nv/S6U20p3RTCv/NuczJNMud+v59/lDHS1mtcI\nm3T1kfZz3OVDOIbD6KlJ45ikpZnCPEdxGG0PX/ECgYEAl6H9W+aIObPhK26WqnG+\nBzlGs61k/0z1NziXud5K1GVTej4Hy8rnqqk24M0ezpuE3JsM+JFQ5mnyJa0dE/bR\n8iAoOFIIC2XL39Nlj5kzgcZq6HfP0QDphNkFsr2scW4UyE/yfJdRlEdFrAmRcglq\nOD243IIfntpYR/3mDhAFkGA=\n-----END PRIVATE KEY-----\n",
//   "client_email": "flutter-rimo@rimorse2-xphn.iam.gserviceaccount.com",
//   "client_id": "104817388204663011631",
//   "auth_uri": "https://accounts.google.com/o/oauth2/auth",
//   "token_uri": "https://oauth2.googleapis.com/token",
//   "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
//   "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/flutter-rimo%40rimorse2-xphn.iam.gserviceaccount.com"
// }
// ''';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap() async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      final storage = await HydratedStorage.build(
        storageDirectory: await getApplicationDocumentsDirectory(),
      );

      final serviceAccountJson =
          await rootBundle.loadString('assets/rimorse2-xphn-7759c5c4dbfb.json');
      final entitiesRepository = EntitiesRepository();
      final dfRepository = DfRepository(
        serviceAccountJson: serviceAccountJson,
        project: 'rimorse2-xphn',
      );

      await HydratedBlocOverrides.runZoned(
        () async => runApp(
          App(
            entitiesRepository: entitiesRepository,
            dfRepository: dfRepository,
          ),
        ),
        blocObserver: AppBlocObserver(),
        storage: storage,
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
