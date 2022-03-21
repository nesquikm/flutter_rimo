import 'package:entities_repository/entities_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rimo/l10n/l10n.dart';
import 'package:flutter_rimo/pages/characters/bloc/characters_bloc.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CharactersBloc(context.read<EntitiesRepository>())
        ..add(CharactersFetchFirstPage()),
      child: const CharactersView(),
    );
  }
}

class CharactersView extends StatelessWidget {
  const CharactersView({Key? key}) : super(key: key);

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
      if (_isBottom()) {
        context.read<CharactersBloc>().add(CharactersFetchNextPage());
      }
    }

    _scrollController.addListener(_onScroll);

    Future<void> _onRefresh() async {
      context.read<CharactersBloc>().add(CharactersReset());
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appBarTitleCharacters)),
      body: MultiBlocListener(
        listeners: [
          BlocListener<CharactersBloc, CharactersState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == CharactersStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(l10n.charactersErrorSnackbarText),
                    ),
                  );
              }
            },
          ),
        ],
        child: BlocBuilder<CharactersBloc, CharactersState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: (state.status == CharactersStatus.failure)
                  ? SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Center(
                        child: Text(l10n.charactersErrorSnackbarText),
                      ),
                    )
                  : (state.characters.isEmpty)
                      ? const SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Center(
                            child: CupertinoActivityIndicator(),
                          ),
                        )
                      : ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: state.characters.length +
                              (state.fetchedAll ? 0 : 1),
                          itemBuilder: (BuildContext context, int index) {
                            if (index == state.characters.length) {
                              return const Center(
                                child: CupertinoActivityIndicator(),
                              );
                            }
                            return CharacterView(
                              character: state.characters.elementAt(index),
                            );
                          },
                          controller: _scrollController,
                        ),
            );
          },
        ),
      ),
    );
  }
}

class CharacterView extends StatelessWidget {
  const CharacterView({Key? key, required this.character}) : super(key: key);
  final Character character;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(foregroundImage: NetworkImage(character.image)),
      title: Text(character.name),
      subtitle: Text('${character.species}, ${character.gender.name}'),
    );
  }
}
