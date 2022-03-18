import 'package:rimo_api/src/models/models.dart';

abstract class Page<E extends Entity> {
  Page(this.info, this.entities);

  /// An info object
  final Info info;

  /// A list of entities
  final List<E> entities;
}
