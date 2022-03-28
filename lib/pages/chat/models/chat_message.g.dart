// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => $checkedCreate(
      'ChatMessage',
      json,
      ($checkedConvert) {
        final val = ChatMessage(
          author: $checkedConvert(
              'author', (v) => $enumDecode(_$ChatMessageAuthorEnumMap, v)),
          text: $checkedConvert('text', (v) => v as String),
          imageUrl: $checkedConvert('image_url', (v) => v as String?),
          entityId: $checkedConvert('entity_id', (v) => v as int?),
        );
        return val;
      },
      fieldKeyMap: const {'imageUrl': 'image_url', 'entityId': 'entity_id'},
    );

Map<String, dynamic> _$ChatMessageToJson(ChatMessage instance) =>
    <String, dynamic>{
      'author': _$ChatMessageAuthorEnumMap[instance.author],
      'text': instance.text,
      'image_url': instance.imageUrl,
      'entity_id': instance.entityId,
    };

const _$ChatMessageAuthorEnumMap = {
  ChatMessageAuthor.human: 'Human',
  ChatMessageAuthor.bot: 'Bot',
};
