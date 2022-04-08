import 'package:entities_repository/entities_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rimo/pages/episodes/bloc/episodes_bloc.dart';
import 'package:flutter_rimo/pages/episodes/view/episodes_view.dart';
import 'package:flutter_rimo/pages/page.dart';

class EpisodesPageConfig extends PageConfig {
  @override
  RIMOPage createPage() => EpisodesPage(this);
}

class EpisodesPage extends RIMOPage<EpisodesPageConfig> {
  const EpisodesPage(EpisodesPageConfig routePath) : super(routePath);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EpisodesBloc(context.read<EntitiesRepository>())
        ..add(EpisodesFetchFirstPage()),
      child: const EpisodesView(),
    );
  }
}
