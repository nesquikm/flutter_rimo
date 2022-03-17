import 'package:dio/dio.dart';
import 'package:rimo_api/src/services/character.dart';
import 'package:rimo_api/src/services/constants.dart';
import 'package:rimo_api/src/services/episode.dart';
import 'package:rimo_api/src/services/location.dart';

export 'services/filters_character.dart';
export 'services/filters_episode.dart';
export 'services/filters_location.dart';

/// {@template rimo_api}
/// The interface and models for an API providing access to backend.
/// {@endtemplate}
class RimoApi {
  /// {@macro rimo_api}
  RimoApi() : dio = Dio(_options) {
    location = ApiLocation(dio: dio);
    episode = ApiEpisode(dio: dio);
    character = ApiCharacter(dio: dio);
  }

  static final _options = BaseOptions(
    baseUrl: Constants.baseURL,
  );

  final Dio dio;
  late final ApiLocation location;
  late final ApiEpisode episode;
  late final ApiCharacter character;
}
