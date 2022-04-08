import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rimo/home/home.dart';
import 'package:flutter_rimo/pages/pages.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => HomeCubit(),
//       child: const HomeView(),
//     );
//   }
// }

// class HomeView extends StatelessWidget {
//   const HomeView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);

//     return Scaffold(
//       body: IndexedStack(
//         index: selectedTab.index,
//         children: const [
//           CharactersPage(),
//           LocationsPage(),
//           EpisodesPage(),
//           ChatPage(),
//         ],
//       ),
//       bottomNavigationBar: BottomAppBar(
//         shape: const CircularNotchedRectangle(),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             _HomeTabButton(
//               groupValue: selectedTab,
//               value: HomeTab.character,
//               icon: Icons.person,
//             ),
//             _HomeTabButton(
//               groupValue: selectedTab,
//               value: HomeTab.location,
//               icon: Icons.location_pin,
//             ),
//             _HomeTabButton(
//               groupValue: selectedTab,
//               value: HomeTab.episode,
//               icon: Icons.list_rounded,
//             ),
//             _HomeTabButton(
//               groupValue: selectedTab,
//               value: HomeTab.chat,
//               icon: Icons.chat,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _HomeTabButton extends StatelessWidget {
//   const _HomeTabButton({
//     Key? key,
//     required this.groupValue,
//     required this.value,
//     required this.icon,
//   }) : super(key: key);

//   final HomeTab groupValue;
//   final HomeTab value;
//   final IconData icon;

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       onPressed: () => context.read<HomeCubit>().setTab(value),
//       iconSize: 32,
//       color:
//           groupValue != value ? null : Theme.of(context).colorScheme.secondary,
//       icon: Icon(
//         icon,
//         color: groupValue != value
//             ? null
//             : Theme.of(context).colorScheme.secondary,
//       ),
//     );
//   }
// }
