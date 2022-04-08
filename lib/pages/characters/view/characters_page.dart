import 'package:entities_repository/entities_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rimo/pages/characters/bloc/characters_bloc.dart';
import 'package:flutter_rimo/pages/characters/view/characters_view.dart';
import 'package:flutter_rimo/pages/page.dart';

class CharactersPageConfig extends PageConfig {
  @override
  RIMOPage createPage() => CharactersPage(this);
}

class CharactersPage extends RIMOPage<CharactersPageConfig> {
  const CharactersPage(CharactersPageConfig routePath) : super(routePath);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CharactersBloc(context.read<EntitiesRepository>())
        ..add(CharactersFetchFirstPage()),
      child: const CharactersView(),
    );
  }
}
