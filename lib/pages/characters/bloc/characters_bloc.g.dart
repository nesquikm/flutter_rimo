// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'characters_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharactersState _$CharactersStateFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CharactersState',
      json,
      ($checkedConvert) {
        final val = CharactersState(
          status: $checkedConvert(
              'status',
              (v) =>
                  $enumDecodeNullable(_$CharactersStatusEnumMap, v) ??
                  CharactersStatus.initial),
          characters: $checkedConvert(
              'characters',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map(
                          (e) => Character.fromJson(e as Map<String, dynamic>))
                      .toList() ??
                  const <Character>[]),
          fetchedAll:
              $checkedConvert('fetched_all', (v) => v as bool? ?? false),
        );
        return val;
      },
      fieldKeyMap: const {'fetchedAll': 'fetched_all'},
    );

Map<String, dynamic> _$CharactersStateToJson(CharactersState instance) =>
    <String, dynamic>{
      'status': _$CharactersStatusEnumMap[instance.status],
      'characters': instance.characters,
      'fetched_all': instance.fetchedAll,
    };

const _$CharactersStatusEnumMap = {
  CharactersStatus.initial: 'initial',
  CharactersStatus.success: 'success',
  CharactersStatus.failure: 'failure',
};
