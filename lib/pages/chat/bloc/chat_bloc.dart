import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:df_repository/df_repository.dart';
import 'package:entities_repository/entities_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_rimo/pages/chat/models/models.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:stream_transform/stream_transform.dart';

part 'chat_bloc.g.dart';
part 'chat_event.dart';
part 'chat_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ChatBloc extends HydratedBloc<ChatEvent, ChatState> {
  ChatBloc(EntitiesRepository entitiesRepository, DfRepository dfRepository)
      : _apiCharacter = entitiesRepository.apiCharacter,
        _dfApi = dfRepository.dfApi,
        super(ChatInitial()) {
    _dfApi.init();
    on<ChatSendTextQuery>(_sendTextQuery);
  }

  @override
  ChatState? fromJson(Map<String, dynamic> json) => ChatState.fromJson(json);

  @override
  Map<String, dynamic> toJson(ChatState state) => state.toJson();

  final ApiCharacter _apiCharacter;
  final DfApi _dfApi;

  Future<void> _sendTextQuery(
    ChatSendTextQuery event,
    Emitter<ChatState> emit,
  ) async {
    try {
      final queryChatMessage =
          ChatMessage(author: ChatMessageAuthor.human, text: event.query);
      emit(
        state.copyWith(
          status: ChatStatus.loading,
          messages: [...state.messages, queryChatMessage],
        ),
      );
      final response = await _dfApi.textQuery(query: event.query);
      final responseChatMessage =
          ChatMessage(author: ChatMessageAuthor.bot, text: response.text);
      emit(
        state.copyWith(
          status: ChatStatus.success,
          messages: [...state.messages, responseChatMessage],
        ),
      );
      if (response.intentName?.toLowerCase() == 'character search' &&
          response.parameters != null &&
          response.parameters!.isNotEmpty) {
        final characterName = response.parameters!['character'];
        if (characterName != null) {
          final pageCharacter = await _apiCharacter.getAllCharacters(
            filters: ApiCharacterFilters(name: characterName),
          );
          final character = pageCharacter.entities
              .firstWhere((character) => character.name == characterName);

          final responseChatMessageExtended = ChatMessage(
            author: ChatMessageAuthor.bot,
            text:
                // ignore: lines_longer_than_80_chars
                '${character.name}: ${character.gender.name}, ${character.species}',
            imageUrl: character.image,
            entityId: character.id,
          );
          emit(
            state.copyWith(
              status: ChatStatus.success,
              messages: [...state.messages, responseChatMessageExtended],
            ),
          );
        }
      }
    } catch (_) {
      emit(state.copyWith(status: ChatStatus.failure));
    }
  }
}
