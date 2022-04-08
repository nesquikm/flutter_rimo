import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_rimo/pages/pages.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'navigation_cubit.g.dart';
part 'navigation_state.dart';

class NavigationCubit extends HydratedCubit<NavigationState> {
  NavigationCubit(List<PageConfig> stack) : super(NavigationState(stack));

  void replace(PageConfig pageConfig) {
    if (pageConfig != state.first) {
      emit(NavigationState([pageConfig]));
    }
  }

  void push(PageConfig pageConfig) {
    if (pageConfig != state.last) {
      emit(NavigationState([...state.configs, pageConfig]));
    }
  }

  void pop() {
    if (state.canPop()) {
      emit(NavigationState(state.configs.sublist(0, state.configs.length - 1)));
    }
  }

  bool canPop() {
    return state.canPop();
  }

  @override
  NavigationState? fromJson(Map<String, dynamic> json) =>
      NavigationState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(NavigationState state) => state.toJson();
}
