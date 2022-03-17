import 'page.dart';
import 'package:rimo_api/src/models/models.dart';

class EpisodePage extends Page<Episode> {
  EpisodePage({required Info info, required List<Episode> entities})
      : super(info, entities);
}
