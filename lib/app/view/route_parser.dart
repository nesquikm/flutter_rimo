import 'package:flutter/material.dart';
import 'package:flutter_rimo/pages/pages.dart';

class RIMORouteInformationParser extends RouteInformationParser<PageConfig> {
  @override
  Future<PageConfig> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '/');
    // TODO(nesquikm): parse and build multiple pages
    if (uri.pathSegments.isNotEmpty) {
      switch (uri.pathSegments.first) {
        case 'characters':
          return CharactersPageConfig();
        // case 'character':
        // TODO(nesquikm): catch error maybe?
        // return CharacterPageConfig(int.parse(uri.pathSegments[1]));
        case 'locations':
          return LocationsPageConfig();
        // case 'location':
        // TODO(nesquikm): catch error maybe?
        // return LocationPageConfig(int.parse(uri.pathSegments[1]));
      }
    } else {
      /// Initial page
      return CharactersPageConfig();
    }
    throw Exception("Can't parse route ${routeInformation.location}");
  }
}
