// ignore_for_file: prefer_const_constructors, cascade_invocations
import 'package:entities_repository/entities_repository.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:test/test.dart';

void main() {
  test('PageableCharacters networking', () async {
    final repository = EntitiesRepository();
    final dioAdapter = DioAdapter(dio: repository.dio);

    dioAdapter.onGet(
      'character',
      (server) => server.reply(200, testCharacterPageResponseFirst),
    );

    dioAdapter.onGet(
      'https://rickandmortyapi.com/api/character/?page=2',
      (server) => server.reply(200, testCharacterPageResponseLast),
    );

    dioAdapter.onGet(
      'character/[10, 28]',
      (server) => server.reply(200, testCharactersResponse),
    );

    expect(repository.newPageableCharacters.entities, isEmpty);

    expect(await repository.newPageableCharacters.getAll(), true);
    expect(repository.newPageableCharacters.entities, isEmpty);
    expect(await repository.newPageableCharacters.getNextPage(), false);

    final pageableCharacters = repository.newPageableCharacters;

    expect(pageableCharacters.entities, isEmpty);

    expect(await pageableCharacters.getAll(), true);
    expect(pageableCharacters.entities.length, 2);
    expect(pageableCharacters.entities[0].id, 10);
    expect(pageableCharacters.entities[1].id, 28);

    expect(await pageableCharacters.getNextPage(), false);
    expect(pageableCharacters.entities.length, 4);
    expect(pageableCharacters.entities[0].id, 10);
    expect(pageableCharacters.entities[1].id, 28);
    expect(pageableCharacters.entities[2].id, 10);
    expect(pageableCharacters.entities[3].id, 28);

    expect(await pageableCharacters.getList(ids: [10, 28]), false);
    expect(pageableCharacters.entities.length, 2);
    expect(pageableCharacters.entities[0].id, 10);
    expect(pageableCharacters.entities[1].id, 28);
  });
}

const testCharactersResponse = [
  {
    'id': 10,
    'name': 'Rick Sanchez',
    'status': 'Alive',
    'species': 'Human',
    'type': '',
    'gender': 'Male',
    'origin': {
      'name': 'Earth (C-137)',
      'url': 'https://rickandmortyapi.com/api/location/1'
    },
    'location': {
      'name': 'Citadel of Ricks',
      'url': 'https://rickandmortyapi.com/api/location/3'
    },
    'image': 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
    'episode': [
      'https://rickandmortyapi.com/api/episode/1',
      'https://rickandmortyapi.com/api/episode/2',
    ],
    'url': 'https://rickandmortyapi.com/api/character/1',
    'created': '2017-11-04T18:48:46.250Z'
  },
  {
    'id': 28,
    'name': 'Johnny Depp',
    'status': 'Alive',
    'species': 'Human',
    'type': '',
    'gender': 'Male',
    'origin': {
      'name': 'Earth (C-500A)',
      'url': 'https://rickandmortyapi.com/api/location/23'
    },
    'location': {
      'name': 'Earth (C-500A)',
      'url': 'https://rickandmortyapi.com/api/location/23'
    },
    'image': 'https://rickandmortyapi.com/api/character/avatar/183.jpeg',
    'episode': ['https://rickandmortyapi.com/api/episode/8'],
    'url': 'https://rickandmortyapi.com/api/character/183',
    'created': '2017-12-29T18:51:29.693Z'
  }
];

const testCharacterPageResponseFirst = {
  'info': {
    'count': 4,
    'pages': 2,
    'next': 'https://rickandmortyapi.com/api/character/?page=2',
    'prev': null,
  },
  'results': testCharactersResponse,
};

const testCharacterPageResponseLast = {
  'info': {
    'count': 4,
    'pages': 2,
    'next': null,
    'prev': 'https://rickandmortyapi.com/api/character/?page=2',
  },
  'results': testCharactersResponse,
};
