import 'package:df_repository/df_repository.dart';
import 'package:entities_repository/entities_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rimo/pages/chat/bloc/chat_bloc.dart';
import 'package:flutter_rimo/pages/chat/view/chat_view.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(
        context.read<EntitiesRepository>(),
        context.read<DfRepository>(),
      ),
      child: ChatView(),
    );
  }
}
