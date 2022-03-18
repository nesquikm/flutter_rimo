import 'package:entities_repository/src/models/pageable.dart';
import 'package:rimo_api/rimo_api.dart';

/// {@template pageable_characters}
/// A repository that handles character requests.
/// {@endtemplate}
class PageableCharacters
    extends Pageable<Character, PageCharacter, ApiCharacterFilters> {
  /// {@macro pageable_characters}
  PageableCharacters({
    required Future<PageCharacter> Function({
      ApiCharacterFilters? filters,
      PageCharacter? nextPage,
      PageCharacter? prevPage,
    })
        getAllEntities,
    required Future<List<Character>> Function({required List<int> ids})
        getListOfEntities,
  }) : super(
          getAllEntities: getAllEntities,
          getListOfEntities: getListOfEntities,
        );
}
