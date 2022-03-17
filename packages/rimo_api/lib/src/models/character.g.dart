// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterLocation _$CharacterLocationFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CharacterLocation',
      json,
      ($checkedConvert) {
        final val = CharacterLocation(
          name: $checkedConvert('name', (v) => v as String),
          url: $checkedConvert('url', (v) => v as String),
        );
        return val;
      },
    );

Character _$CharacterFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Character',
      json,
      ($checkedConvert) {
        final val = Character(
          id: $checkedConvert('id', (v) => v as int),
          name: $checkedConvert('name', (v) => v as String),
          status: $checkedConvert(
              'status', (v) => $enumDecode(_$CharacterStatusEnumMap, v)),
          species: $checkedConvert('species', (v) => v as String),
          type: $checkedConvert('type', (v) => v as String),
          gender: $checkedConvert(
              'gender', (v) => $enumDecode(_$CharacterGenderEnumMap, v)),
          origin: $checkedConvert('origin',
              (v) => CharacterLocation.fromJson(v as Map<String, dynamic>)),
          location: $checkedConvert('location',
              (v) => CharacterLocation.fromJson(v as Map<String, dynamic>)),
          image: $checkedConvert('image', (v) => v as String),
          episode: $checkedConvert('episode',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          url: $checkedConvert('url', (v) => v as String),
          created:
              $checkedConvert('created', (v) => DateTime.parse(v as String)),
        );
        return val;
      },
    );

const _$CharacterStatusEnumMap = {
  CharacterStatus.alive: 'Alive',
  CharacterStatus.dead: 'Dead',
  CharacterStatus.unknown: 'unknown',
};

const _$CharacterGenderEnumMap = {
  CharacterGender.female: 'Female',
  CharacterGender.male: 'Male',
  CharacterGender.genderless: 'Genderless',
  CharacterGender.unknown: 'unknown',
};
