import 'package:entities_repository/entities_repository.dart';
import 'package:flutter/material.dart';

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
