import 'package:rimo_api/src/services/filters.dart';

class ApiLocationFilters extends ApiFilters {
  ApiLocationFilters({this.name, this.type, this.dimension});

  final String? name;
  final String? type;
  final String? dimension;

  @override
  Map<String, String?> getFields() {
    return {'name': name, 'type': type, 'dimension': dimension};
  }
}
