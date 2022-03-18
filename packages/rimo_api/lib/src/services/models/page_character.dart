import 'package:rimo_api/src/models/models.dart';
import 'package:rimo_api/src/services/models/page.dart';

/// {@template character_page}
/// CharacterPage includes Info and list of characters
/// {@endtemplate}
class PageCharacter extends Page<Character> {
  /// {@macro character_page}
  PageCharacter({required Info info, required List<Character> entities})
      : super(info, entities);
}
