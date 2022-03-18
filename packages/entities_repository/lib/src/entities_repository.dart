import 'package:dio/dio.dart';
import 'package:entities_repository/src/models/models.dart';
import 'package:rimo_api/rimo_api.dart';

/// {@template entities_repository}
/// A repository that handles character, location and episode related requests.
/// {@endtemplate}
class EntitiesRepository {
  /// {@macro entities_repository}
  EntitiesRepository() {
    _rimoApi = RimoApi();

    pageableCharacters = PageableCharacters(
      getAllEntities: _rimoApi.character.getAllCharacters,
      getListOfEntities: _rimoApi.character.getListOfCharacters,
    );

    pageableEpisodes = PageableEpisodes(
      getAllEntities: _rimoApi.episode.getAllEpisodes,
      getListOfEntities: _rimoApi.episode.getListOfEpisodes,
    );

    pageableLocations = PageableLocations(
      getAllEntities: _rimoApi.location.getAllLocations,
      getListOfEntities: _rimoApi.location.getListOfLocations,
    );
  }

  /// Public Dio getter
  Dio get dio => _rimoApi.dio;

  late final RimoApi _rimoApi;

  /// Ready for use PageableCharacters instance
  late final PageableCharacters pageableCharacters;

  /// Ready for use PageableEpisodes instance
  late final PageableEpisodes pageableEpisodes;

  /// Ready for use PageableLocations instance
  late final PageableLocations pageableLocations;
}
