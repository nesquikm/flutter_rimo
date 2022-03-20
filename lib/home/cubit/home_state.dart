part of 'home_cubit.dart';

enum HomeTab { character, location, episode }

@JsonSerializable()
class HomeState extends Equatable {
  const HomeState(this.tab);

  /// Create state  from json
  factory HomeState.fromJson(Map<String, dynamic> json) =>
      _$HomeStateFromJson(json);

  Map<String, dynamic> toJson() => _$HomeStateToJson(this);

  final HomeTab tab;

  @override
  List<Object> get props => [tab];
}
