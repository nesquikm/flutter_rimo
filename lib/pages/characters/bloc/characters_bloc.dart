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
      : _apiCharacter = entitiesRepository.apiCharacter,
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

  final ApiCharacter _apiCharacter;

  Future<void> _reset(
    CharactersReset event,
    Emitter<CharactersState> emit,
  ) async {
    emit(CharactersInitial());
    add(CharactersFetchNextPage());
  }

  Future<void> _fetchNextPage(
    CharactersFetchNextPage event,
    Emitter<CharactersState> emit,
  ) async {
    try {
      if (state.fetchedAll) {
        return;
      }

      final page =
          await _apiCharacter.getAllCharacters(prevPage: state.lastPage);
      emit(
        state.copyWith(
          status: CharactersStatus.success,
          characters: [...state.characters, ...page.entities],
          lastPage: page,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: CharactersStatus.failure));
    }
  }
}
