import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rimo/app/cubit/navigation_cubit.dart';
import 'package:flutter_rimo/pages/pages.dart';

class RIMORouterDelegate extends RouterDelegate<PageConfig> with ChangeNotifier
// , PopNavigatorRouterDelegateMixin<PageConfig>
{
  RIMORouterDelegate(this._navigationCubit);
  // : _navigatorKey = GlobalKey<NavigatorState>();

  final NavigationCubit _navigationCubit;
  // final GlobalKey<NavigatorState> _navigatorKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) => Navigator(
        pages: state.pages,
        // key: _navigatorKey,
        onPopPage: _onPopPage,
      ),
    );
  }

  // @override
  // GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;
  /// TODO(nesquikm): enable PopNavigatorRouterDelegateMixin, and _navigatorKey
  @override
  Future<bool> popRoute() async {
    if (_navigationCubit.canPop()) {
      _navigationCubit.pop();
      return true;
    }
    return false;
  }

  @override
  Future<void> setNewRoutePath(PageConfig configuration) async {
    _navigationCubit.push(configuration);
  }

  bool _onPopPage(Route route, dynamic result) {
    if (!route.didPop(result)) {
      return false;
    }

    if (_navigationCubit.canPop()) {
      _navigationCubit.pop();
      return true;
    }

    return false;
  }
}
