import 'package:entities_repository/entities_repository.dart';
import 'package:flutter/material.dart';

class EpisodeView extends StatelessWidget {
  const EpisodeView({Key? key, required this.episode}) : super(key: key);
  final Episode episode;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(episode.name),
      subtitle: Text('${episode.episode}, ${episode.airDate}'),
    );
  }
}
