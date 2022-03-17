import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rimo_api/src/models/models.dart';
import 'package:rimo_api/src/services/constants.dart';
import 'package:rimo_api/src/services/models/models.dart';

/// {@template rimo_api_character}
/// The interface and models for an API providing access to character.
// /// {@endtemplate}

class ApiCharacterFailure implements Exception {}

/// {@macro rimo_api_character}
class ApiCharacter {
  /// {@macro rimo_api_character}
  ApiCharacter({required this.dio});

  final Dio dio;

  Future<CharacterPage> getAllCharacters({
    ApiCharacterFilters? filters,
    CharacterPage? prevPage,
    CharacterPage? nextPage,
  }) async {
    try {
      final url = filters != null
          ? '${Constants.characterEndpoint}${filters.getQuery()}'
          : prevPage?.info.next != null
              ? prevPage!.info.next!
              : nextPage?.info.prev != null
                  ? nextPage!.info.prev!
                  : Constants.characterEndpoint;

      final response = await dio.get<Map<String, dynamic>>(url);

      final info =
          Info.fromJson(response.data!['info'] as Map<String, dynamic>);

      final characters = List<Character>.from(
        List<Map<String, dynamic>>.from(response.data!['results'] as List)
            .map<Character>(Character.fromJson),
      );

      return CharacterPage(info: info, entities: characters);
    } catch (e) {
      log(e.toString());
      throw ApiCharacterFailure();
    }
  }

  Future<List<Character>> getListOfCharacters({required List<int> ids}) async {
    try {
      final url = '${Constants.characterEndpoint}/$ids';

      final response = await dio.get<List<dynamic>>(url);

      return List<Character>.from(
        List<Map<String, dynamic>>.from(response.data!)
            .map<Character>(Character.fromJson),
      );
    } catch (e) {
      log(e.toString());
      throw ApiCharacterFailure();
    }
  }
}
