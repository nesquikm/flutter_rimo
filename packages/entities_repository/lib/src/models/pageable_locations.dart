import 'package:entities_repository/src/models/pageable.dart';
import 'package:rimo_api/rimo_api.dart';

class PageableLocations
    extends Pageable<Location, LocationPage, ApiLocationFilters> {
  PageableLocations(
      {required Future<LocationPage> Function(
              {ApiLocationFilters? filters,
              LocationPage? nextPage,
              LocationPage? prevPage})
          getAllEntities,
      required Future<List<Location>> Function({required List<int> ids})
          getListOfEntities})
      : super(
            getAllEntities: getAllEntities,
            getListOfEntities: getListOfEntities);
}
