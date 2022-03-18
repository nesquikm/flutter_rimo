import 'package:entities_repository/src/models/pageable.dart';
import 'package:rimo_api/rimo_api.dart';

/// {@template pageable_episodes}
/// A repository that handles episode requests.
/// {@endtemplate}
class PageableEpisodes
    extends Pageable<Episode, PageEpisode, ApiEpisodeFilters> {
  /// {@macro pageable_episodes}
  PageableEpisodes({
    required Future<PageEpisode> Function({
      ApiEpisodeFilters? filters,
      PageEpisode? nextPage,
      PageEpisode? prevPage,
    })
        getAllEntities,
    required Future<List<Episode>> Function({required List<int> ids})
        getListOfEntities,
  }) : super(
          getAllEntities: getAllEntities,
          getListOfEntities: getListOfEntities,
        );
}
