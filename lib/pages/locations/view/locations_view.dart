import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rimo/l10n/l10n.dart';
import 'package:flutter_rimo/pages/locations/bloc/locations_bloc.dart';
import 'package:flutter_rimo/pages/locations/view/location_view.dart';

class LocationsView extends StatelessWidget {
  const LocationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final _scrollController = ScrollController();

    bool _isBottom() {
      if (!_scrollController.hasClients) return false;
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.offset;
      return currentScroll >= (maxScroll * 0.9);
    }

    void _onScroll() {
      if (_isBottom() && !context.read<LocationsBloc>().state.fetchedAll) {
        context.read<LocationsBloc>().add(const LocationsFetchNextPage());
      }
    }

    _scrollController.addListener(_onScroll);

    Future<void> _onRefresh() async {
      context.read<LocationsBloc>().add(LocationsReset());
      await context
          .read<LocationsBloc>()
          .stream
          .firstWhere((element) => element.status != LocationsStatus.loading);
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appBarTitleLocations)),
      body: MultiBlocListener(
        listeners: [
          BlocListener<LocationsBloc, LocationsState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == LocationsStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(l10n.locationsErrorSnackbarText),
                    ),
                  );
              }
            },
          ),
        ],
        child: BlocBuilder<LocationsBloc, LocationsState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: Stack(
                children: [
                  ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount:
                        state.locations.length + (state.fetchedAll ? 0 : 1),
                    itemBuilder: (BuildContext context, int index) {
                      if (index == state.locations.length) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return LocationView(
                        location: state.locations.elementAt(index),
                      );
                    },
                    controller: _scrollController,
                  ),
                  Center(
                    child: (state.status == LocationsStatus.failure)
                        ? const CircularProgressIndicator()
                        : null,
                  ),
                  Center(
                    child: (state.status == LocationsStatus.initial)
                        ? Text(l10n.locationsErrorSnackbarText)
                        : null,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
