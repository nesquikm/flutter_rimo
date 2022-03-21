import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:entities_repository/entities_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:stream_transform/stream_transform.dart';

part 'characters_bloc.g.dart';
part 'characters_event.dart';
part 'characters_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class CharactersBloc extends HydratedBloc<CharactersEvent, CharactersState> {
  CharactersBloc(EntitiesRepository entitiesRepository)
      : _pageableCharacters = entitiesRepository.newPageableCharacters,
        super(CharactersInitial()) {
    on<CharactersReset>(
      _reset,
      transformer: throttleDroppable(throttleDuration),
    );

    on<CharactersFetchNextPage>(
      _fetchNextPage,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  @override
  CharactersState? fromJson(Map<String, dynamic> json) =>
      CharactersState.fromJson(json);

  @override
  Map<String, dynamic> toJson(CharactersState state) => state.toJson();

  final PageableCharacters _pageableCharacters;

  Future<void> _reset(
    CharactersReset event,
    Emitter<CharactersState> emit,
  ) async {
    emit(CharactersInitial());

    await _fetch(reset: true, emit: emit);
  }

  Future<void> _fetchNextPage(
    CharactersFetchNextPage event,
    Emitter<CharactersState> emit,
  ) async {
    await _fetch(emit: emit);
  }

  Future<void> _fetch({
    bool reset = false,
    required Emitter<CharactersState> emit,
  }) async {
    try {
      if (state.fetchedAll && !reset) {
        return;
      }
      final haveMorePages = _pageableCharacters.entities.isEmpty || reset
          ? await _pageableCharacters.getAll()
          : await _pageableCharacters.getNextPage();
      emit(
        CharactersState(
          status: CharactersStatus.success,
          characters: _pageableCharacters.entities,
          fetchedAll: !haveMorePages,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: CharactersStatus.failure));
    }
  }
}
