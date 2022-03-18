import 'package:rimo_api/src/models/models.dart';
import 'package:rimo_api/src/services/models/page.dart';

/// {@template location_page}
/// LocationPage includes Info and list of characters
/// {@endtemplate}
class LocationPage extends Page<Location> {
  /// {@macro location_page}
  LocationPage({required Info info, required List<Location> entities})
      : super(info, entities);
}
