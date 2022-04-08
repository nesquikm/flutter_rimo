part of 'navigation_cubit.dart';

@JsonSerializable()
class NavigationState extends Equatable {
  const NavigationState(this.stack);

  final List<PageConfig> stack;

  List<RIMOPage> get pages => List.unmodifiable(
        stack.map<RIMOPage<PageConfig>>((e) => e.page),
      );
  List<PageConfig> get configs => stack;
  int get length => stack.length;
  PageConfig get first => stack.first;
  PageConfig get last => stack.last;

  bool canPop() {
    return stack.length > 1;
  }

  /// Create state  from json
  factory NavigationState.fromJson(Map<String, dynamic> json) =>
      _$NavigationStateFromJson(json);

  Map<String, dynamic> toJson() => _$NavigationStateToJson(this);

  @override
  List<Object> get props => [stack];
}
