import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rimo/l10n/l10n.dart';
import 'package:flutter_rimo/pages/episodes/bloc/episodes_bloc.dart';
import 'package:flutter_rimo/pages/episodes/view/episode_view.dart';

class EpisodesView extends StatelessWidget {
  const EpisodesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final _scrollController = ScrollController();

    bool _isBottom() {
      if (!_scrollController.hasClients) return false;
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.offset;
      return currentScroll >= (maxScroll * 0.9);
    }

    void _onScroll() {
      if (_isBottom() && !context.read<EpisodesBloc>().state.fetchedAll) {
        context.read<EpisodesBloc>().add(const EpisodesFetchNextPage());
      }
    }

    _scrollController.addListener(_onScroll);

    Future<void> _onRefresh() async {
      context.read<EpisodesBloc>().add(EpisodesReset());
      await context
          .read<EpisodesBloc>()
          .stream
          .firstWhere((element) => element.status != EpisodesStatus.loading);
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appBarTitleEpisodes)),
      body: MultiBlocListener(
        listeners: [
          BlocListener<EpisodesBloc, EpisodesState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == EpisodesStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(l10n.episodesErrorSnackbarText),
                    ),
                  );
              }
            },
          ),
        ],
        child: BlocBuilder<EpisodesBloc, EpisodesState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: Stack(
                children: [
                  ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount:
                        state.episodes.length + (state.fetchedAll ? 0 : 1),
                    itemBuilder: (BuildContext context, int index) {
                      if (index == state.episodes.length) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return EpisodeView(
                        episode: state.episodes.elementAt(index),
                      );
                    },
                    controller: _scrollController,
                  ),
                  Center(
                    child: (state.status == EpisodesStatus.failure)
                        ? const CircularProgressIndicator()
                        : null,
                  ),
                  Center(
                    child: (state.status == EpisodesStatus.initial)
                        ? Text(l10n.episodesErrorSnackbarText)
                        : null,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
