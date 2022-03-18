import 'package:entities_repository/src/models/pageable.dart';
import 'package:rimo_api/rimo_api.dart';

/// {@template pageable_episodes}
/// A repository that handles episode requests.
/// {@endtemplate}
class PageableEpisodes
    extends Pageable<Episode, EpisodePage, ApiEpisodeFilters> {
  /// {@macro pageable_episodes}
  PageableEpisodes({
    required Future<EpisodePage> Function({
      ApiEpisodeFilters? filters,
      EpisodePage? nextPage,
      EpisodePage? prevPage,
    })
        getAllEntities,
    required Future<List<Episode>> Function({required List<int> ids})
        getListOfEntities,
  }) : super(
          getAllEntities: getAllEntities,
          getListOfEntities: getListOfEntities,
        );
}
