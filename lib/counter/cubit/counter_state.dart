part of 'counter_cubit.dart';

@JsonSerializable()
class CounterState extends Equatable {
  /// Create explicit state
  const CounterState({
    required this.count,
  });

  /// Create state  from json
  factory CounterState.fromJson(Map<String, dynamic> json) =>
      _$CounterStateFromJson(json);

  final int count;

  CounterState copyWith({
    int? count,
  }) {
    return CounterState(
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toJson() => _$CounterStateToJson(this);

  @override
  List<Object> get props => [
        count,
      ];
}
