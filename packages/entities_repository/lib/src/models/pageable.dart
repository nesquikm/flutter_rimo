import 'package:rimo_api/rimo_api.dart';

abstract class Pageable<E extends Entity, P extends Page<E>,
    F extends ApiFilters> {
  Pageable({required this.getAllEntities, required this.getListOfEntities});

  final List<E> entities = [];
  P? _lastReceivedPage;
  final Future<P> Function({
    F? filters,
    P? prevPage,
    P? nextPage,
  }) getAllEntities;

  final Future<List<E>> Function({required List<int> ids}) getListOfEntities;

  Future<bool> getAll({F? filters}) async {
    _lastReceivedPage = await getAllEntities(filters: filters);
    entities
      ..clear()
      ..addAll(_lastReceivedPage!.entities);
    return _lastReceivedPage?.info.next != null;
  }

  Future<bool> getNextPage() async {
    if (_lastReceivedPage?.info.next != null) {
      _lastReceivedPage = await getAllEntities(prevPage: _lastReceivedPage);
      entities.addAll(_lastReceivedPage!.entities);
      return _lastReceivedPage?.info.next != null;
    }
    return false;
  }

  Future<bool> getList({required List<int> ids}) async {
    var list = await getListOfEntities(ids: ids);
    _lastReceivedPage = null;
    entities
      ..clear()
      ..addAll(list);
    return false;
  }
}
