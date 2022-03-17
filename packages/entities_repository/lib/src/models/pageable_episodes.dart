import 'package:entities_repository/src/models/pageable.dart';
import 'package:rimo_api/rimo_api.dart';

class PageableEpisodes
    extends Pageable<Episode, EpisodePage, ApiEpisodeFilters> {
  PageableEpisodes(
      {required Future<EpisodePage> Function(
              {ApiEpisodeFilters? filters,
              EpisodePage? nextPage,
              EpisodePage? prevPage})
          getAllEntities,
      required Future<List<Episode>> Function({required List<int> ids})
          getListOfEntities})
      : super(
            getAllEntities: getAllEntities,
            getListOfEntities: getListOfEntities);
}
