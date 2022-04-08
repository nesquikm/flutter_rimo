// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'navigation_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NavigationState _$NavigationStateFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'NavigationState',
      json,
      ($checkedConvert) {
        final val = NavigationState(
          $checkedConvert(
              'stack',
              (v) => (v as List<dynamic>)
                  .map((e) => PageConfig.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$NavigationStateToJson(NavigationState instance) =>
    <String, dynamic>{
      'stack': instance.stack,
    };
