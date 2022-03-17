// ignore_for_file: prefer_const_constructors, cascade_invocations
import 'package:entities_repository/entities_repository.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:test/test.dart';

void main() {
  test('PageableEpisodes networking', () async {
    final repository = EntitiesRepository();
    final dioAdapter = DioAdapter(dio: repository.dio);

    dioAdapter.onGet(
      'episode',
      (server) => server.reply(200, testEpisodePageResponseFirst),
    );

    dioAdapter.onGet(
      'https://rickandmortyapi.com/api/episode/?page=2',
      (server) => server.reply(200, testEpisodePageResponseLast),
    );

    dioAdapter.onGet(
      'episode/[10, 28]',
      (server) => server.reply(200, testEpisodesResponse),
    );

    expect(repository.pageableEpisodes.entities, isEmpty);

    expect(await repository.pageableEpisodes.getAll(), true);
    expect(repository.pageableEpisodes.entities.length, 2);
    expect(repository.pageableEpisodes.entities[0].id, 10);
    expect(repository.pageableEpisodes.entities[1].id, 28);

    expect(await repository.pageableEpisodes.getNextPage(), false);
    expect(repository.pageableEpisodes.entities.length, 4);
    expect(repository.pageableEpisodes.entities[0].id, 10);
    expect(repository.pageableEpisodes.entities[1].id, 28);
    expect(repository.pageableEpisodes.entities[2].id, 10);
    expect(repository.pageableEpisodes.entities[3].id, 28);

    expect(await repository.pageableEpisodes.getList(ids: [10, 28]), false);
    expect(repository.pageableEpisodes.entities.length, 2);
    expect(repository.pageableEpisodes.entities[0].id, 10);
    expect(repository.pageableEpisodes.entities[1].id, 28);
  });
}

const testEpisodesResponse = [
  {
    'id': 10,
    'name': 'Close Rick-counters of the Rick Kind',
    'air_date': 'April 7, 2014',
    'episode': 'S01E10',
    'characters': [
      'https://rickandmortyapi.com/api/character/1',
      'https://rickandmortyapi.com/api/character/2',
    ],
    'url': 'https://rickandmortyapi.com/api/episode/10',
    'created': '2017-11-10T12:56:34.747Z'
  },
  {
    'id': 28,
    'name': 'The Ricklantis Mixup',
    'air_date': 'September 10, 2017',
    'episode': 'S03E07',
    'characters': [
      'https://rickandmortyapi.com/api/character/1',
      'https://rickandmortyapi.com/api/character/2',
    ],
    'url': 'https://rickandmortyapi.com/api/episode/28',
    'created': '2017-11-10T12:56:36.618Z'
  }
];

const testEpisodePageResponseFirst = {
  'info': {
    'count': 4,
    'pages': 2,
    'next': 'https://rickandmortyapi.com/api/episode/?page=2',
    'prev': null,
  },
  'results': testEpisodesResponse,
};

const testEpisodePageResponseLast = {
  'info': {
    'count': 4,
    'pages': 2,
    'next': null,
    'prev': 'https://rickandmortyapi.com/api/episode/?page=2',
  },
  'results': testEpisodesResponse,
};
