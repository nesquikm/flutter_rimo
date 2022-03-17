import 'page.dart';
import 'package:rimo_api/src/models/models.dart';

class CharacterPage extends Page<Character> {
  CharacterPage({required Info info, required List<Character> entities})
      : super(info, entities);
}
