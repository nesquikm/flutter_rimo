import 'package:rimo_api/src/models/models.dart';
import 'package:rimo_api/src/services/filters.dart';
import 'package:enum_to_string/enum_to_string.dart';

class ApiCharacterFilters extends ApiFilters {
  ApiCharacterFilters({
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
  });

  final String? name;
  final CharacterStatus? status;
  final String? species;
  final String? type;
  final CharacterGender? gender;

  @override
  Map<String, String?> getFields() {
    return {
      'name': name,
      'status': status != null ? EnumToString.convertToString(status) : null,
      'species': species,
      'type': type,
      'gender': gender != null ? EnumToString.convertToString(gender) : null,
    };
  }
}
