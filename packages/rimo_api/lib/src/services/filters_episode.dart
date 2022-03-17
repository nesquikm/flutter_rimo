import 'package:rimo_api/src/services/filters.dart';

class ApiEpisodeFilters extends ApiFilters {
  ApiEpisodeFilters({this.name, this.episode});

  final String? name;
  final String? episode;

  @override
  Map<String, String?> getFields() {
    return {'name': name, 'episode': episode};
  }
}
