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
  }

  /// Public Dio getter
  Dio get dio => _rimoApi.dio;

  late final RimoApi _rimoApi;

  /// Create a new instance of PageableCharacters instance
  PageableCharacters get newPageableCharacters => PageableCharacters(
        getAllEntities: _rimoApi.character.getAllCharacters,
        getListOfEntities: _rimoApi.character.getListOfCharacters,
      );

  /// Create a new instance of PageableEpisodes
  PageableEpisodes get newPageableEpisodes => PageableEpisodes(
        getAllEntities: _rimoApi.episode.getAllEpisodes,
        getListOfEntities: _rimoApi.episode.getListOfEpisodes,
      );

  /// Create a new instance of PageableLocations
  PageableLocations get newPageableLocations => PageableLocations(
        getAllEntities: _rimoApi.location.getAllLocations,
        getListOfEntities: _rimoApi.location.getListOfLocations,
      );
}
