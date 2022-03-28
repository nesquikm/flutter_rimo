// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'home_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeState _$HomeStateFromJson(Map<String, dynamic> json) => $checkedCreate(
      'HomeState',
      json,
      ($checkedConvert) {
        final val = HomeState(
          $checkedConvert('tab', (v) => $enumDecode(_$HomeTabEnumMap, v)),
        );
        return val;
      },
    );

Map<String, dynamic> _$HomeStateToJson(HomeState instance) => <String, dynamic>{
      'tab': _$HomeTabEnumMap[instance.tab],
    };

const _$HomeTabEnumMap = {
  HomeTab.character: 'character',
  HomeTab.location: 'location',
  HomeTab.episode: 'episode',
  HomeTab.chat: 'chat',
};
