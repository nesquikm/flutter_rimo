// ignore_for_file: prefer_const_constructors, cascade_invocations
import 'package:entities_repository/entities_repository.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:test/test.dart';

void main() {
  test('PageableLocations networking', () async {
    final repository = EntitiesRepository();
    final dioAdapter = DioAdapter(dio: repository.dio);

    dioAdapter.onGet(
      'location',
      (server) => server.reply(200, testLocationPageResponseFirst),
    );

    dioAdapter.onGet(
      'https://rickandmortyapi.com/api/location/?page=2',
      (server) => server.reply(200, testLocationPageResponseLast),
    );

    dioAdapter.onGet(
      'location/[10, 28]',
      (server) => server.reply(200, testLocationsResponse),
    );

    expect(repository.pageableLocations.entities, isEmpty);

    expect(await repository.pageableLocations.getAll(), true);
    expect(repository.pageableLocations.entities.length, 2);
    expect(repository.pageableLocations.entities[0].id, 10);
    expect(repository.pageableLocations.entities[1].id, 28);

    expect(await repository.pageableLocations.getNextPage(), false);
    expect(repository.pageableLocations.entities.length, 4);
    expect(repository.pageableLocations.entities[0].id, 10);
    expect(repository.pageableLocations.entities[1].id, 28);
    expect(repository.pageableLocations.entities[2].id, 10);
    expect(repository.pageableLocations.entities[3].id, 28);

    expect(await repository.pageableLocations.getList(ids: [10, 28]), false);
    expect(repository.pageableLocations.entities.length, 2);
    expect(repository.pageableLocations.entities[0].id, 10);
    expect(repository.pageableLocations.entities[1].id, 28);
  });
}

const testLocationsResponse = [
  {
    'id': 10,
    'name': 'Citadel of Ricks',
    'type': 'Space station',
    'dimension': 'unknown',
    'residents': [
      'https://rickandmortyapi.com/api/character/8',
      'https://rickandmortyapi.com/api/character/14',
      'https://rickandmortyapi.com/api/character/15',
    ],
    'url': 'https://rickandmortyapi.com/api/location/3',
    'created': '2017-11-10T13:08:13.191Z'
  },
  {
    'id': 28,
    'name': 'Immortality Field Resort',
    'type': 'Resort',
    'dimension': 'unknown',
    'residents': [
      'https://rickandmortyapi.com/api/character/23',
      'https://rickandmortyapi.com/api/character/204',
      'https://rickandmortyapi.com/api/character/320'
    ],
    'url': 'https://rickandmortyapi.com/api/location/7',
    'created': '2017-11-10T13:09:17.136Z'
  },
];

const testLocationPageResponseFirst = {
  'info': {
    'count': 4,
    'pages': 2,
    'next': 'https://rickandmortyapi.com/api/location/?page=2',
    'prev': null,
  },
  'results': testLocationsResponse,
};

const testLocationPageResponseLast = {
  'info': {
    'count': 4,
    'pages': 2,
    'next': null,
    'prev': 'https://rickandmortyapi.com/api/location/?page=2',
  },
  'results': testLocationsResponse,
};
