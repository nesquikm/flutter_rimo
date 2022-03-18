import 'package:rimo_api/src/models/models.dart';
import 'package:rimo_api/src/services/models/page.dart';

/// {@template episode_page}
/// EpisodePage includes Info and list of characters
/// {@endtemplate}
class EpisodePage extends Page<Episode> {
  /// {@macro episode_page}
  EpisodePage({required Info info, required List<Episode> entities})
      : super(info, entities);
}
