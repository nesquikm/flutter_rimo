import 'package:entities_repository/entities_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rimo/pages/locations/bloc/locations_bloc.dart';
import 'package:flutter_rimo/pages/locations/view/locations_view.dart';
import 'package:flutter_rimo/pages/page.dart';

class LocationsPageConfig extends PageConfig {
  @override
  RIMOPage createPage() => LocationsPage(this);
}

class LocationsPage extends RIMOPage<LocationsPageConfig> {
  const LocationsPage(LocationsPageConfig routePath) : super(routePath);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationsBloc(context.read<EntitiesRepository>())
        ..add(LocationsFetchFirstPage()),
      child: const LocationsView(),
    );
  }
}
