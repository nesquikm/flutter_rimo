import 'package:entities_repository/src/models/pageable.dart';
import 'package:rimo_api/rimo_api.dart';

/// {@template pageable_locations}
/// A repository that handles location requests.
/// {@endtemplate}
class PageableLocations
    extends Pageable<Location, LocationPage, ApiLocationFilters> {
  /// {@macro pageable_locations}
  PageableLocations({
    required Future<LocationPage> Function({
      ApiLocationFilters? filters,
      LocationPage? nextPage,
      LocationPage? prevPage,
    })
        getAllEntities,
    required Future<List<Location>> Function({required List<int> ids})
        getListOfEntities,
  }) : super(
          getAllEntities: getAllEntities,
          getListOfEntities: getListOfEntities,
        );
}
