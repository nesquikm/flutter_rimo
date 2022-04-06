import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeNavigator extends StatelessWidget {
  const HomeNavigator({
    Key? key,
    required this.context,
    required this.state,
    required this.child,
  }) : super(key: key);

  final BuildContext context;
  final GoRouterState state;
  final Widget child;

  void _onPressIcon(String name) {
    context.goNamed(name);
  }

  @override
  Widget build(BuildContext context) {
    final activeName = Uri.parse(state.location).pathSegments.first;
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _HomeTabButton(
              name: 'characters',
              activeName: activeName,
              icon: Icons.person,
              onPress: _onPressIcon,
            ),
            _HomeTabButton(
              name: 'locations',
              activeName: activeName,
              icon: Icons.location_pin,
              onPress: _onPressIcon,
            ),
            _HomeTabButton(
              name: 'episodes',
              activeName: activeName,
              icon: Icons.list_rounded,
              onPress: _onPressIcon,
            ),
            _HomeTabButton(
              name: 'chat',
              activeName: activeName,
              icon: Icons.chat,
              onPress: _onPressIcon,
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeTabButton extends StatelessWidget {
  const _HomeTabButton({
    Key? key,
    required this.name,
    this.activeName,
    required this.icon,
    required this.onPress,
  }) : super(key: key);

  final String name;
  final String? activeName;
  final IconData icon;
  final Function(String) onPress;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onPress(name),
      iconSize: 32,
      color:
          name == activeName ? Theme.of(context).colorScheme.secondary : null,
      icon: Icon(
        icon,
      ),
    );
  }
}
