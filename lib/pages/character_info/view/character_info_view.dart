import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rimo/l10n/l10n.dart';
import 'package:flutter_rimo/pages/character_info/bloc/character_info_bloc.dart';

class CharacterInfoView extends StatelessWidget {
  const CharacterInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    Future<void> _onRefresh() async {
      context.read<CharacterInfoBloc>().add(CharacterInfoRefresh());
      await context.read<CharacterInfoBloc>().stream.firstWhere(
            (element) => element.status != CharacterInfoStatus.loading,
          );
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appBarTitleCharacter)),
      body: MultiBlocListener(
        listeners: [
          BlocListener<CharacterInfoBloc, CharacterInfoState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == CharacterInfoStatus.failure) {
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
        child: BlocBuilder<CharacterInfoBloc, CharacterInfoState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: const Text('test'),
            );
          },
        ),
      ),
    );
  }
}
