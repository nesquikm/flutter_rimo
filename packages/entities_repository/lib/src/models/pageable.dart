import 'package:rimo_api/rimo_api.dart';

/// {@template pageable}
/// An abstract repository that handles api requests.
/// {@endtemplate}
abstract class Pageable<E extends Entity, P extends Page<E>,
    F extends ApiFilters> {
  /// {@macro pageable}
  Pageable({required this.getAllEntities, required this.getListOfEntities});

  /// Gathered entities list
  final List<E> entities = [];

  P? _lastReceivedPage;

  /// Get all entities (filtred/paged)
  final Future<P> Function({
    F? filters,
    P? prevPage,
    P? nextPage,
  }) getAllEntities;

  /// Get list of entities byt id
  final Future<List<E>> Function({required List<int> ids}) getListOfEntities;

  /// Get the first page of entities (filtred) and store to entities field
  Future<bool> getAll({F? filters}) async {
    _lastReceivedPage = await getAllEntities(filters: filters);
    entities
      ..clear()
      ..addAll(_lastReceivedPage!.entities);
    return _lastReceivedPage?.info.next != null;
  }

  /// Subsequently get pages of entities and store to entities field
  Future<bool> getNextPage() async {
    if (_lastReceivedPage?.info.next != null) {
      _lastReceivedPage = await getAllEntities(prevPage: _lastReceivedPage);
      entities.addAll(_lastReceivedPage!.entities);
      return _lastReceivedPage?.info.next != null;
    }
    return false;
  }

  /// Get list of entities byt id and store to entities field
  Future<bool> getList({required List<int> ids}) async {
    final list = await getListOfEntities(ids: ids);
    _lastReceivedPage = null;
    entities
      ..clear()
      ..addAll(list);
    return false;
  }
}
