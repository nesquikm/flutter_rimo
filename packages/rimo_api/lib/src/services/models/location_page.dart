import 'page.dart';
import 'package:rimo_api/src/models/models.dart';

class LocationPage extends Page<Location> {
  LocationPage({required Info info, required List<Location> entities})
      : super(info, entities);
}
