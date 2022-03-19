// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'counter_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CounterState _$CounterStateFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CounterState',
      json,
      ($checkedConvert) {
        final val = CounterState(
          count: $checkedConvert('count', (v) => v as int),
        );
        return val;
      },
    );

Map<String, dynamic> _$CounterStateToJson(CounterState instance) =>
    <String, dynamic>{
      'count': instance.count,
    };
