import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

 import '../../../core/usecase/base_usecase.dart';
import '../../../core/utilis/enums.dart';
import '../../domain/usecases/get_now_playing.dart';
import '../../domain/usecases/get_popular.dart';
import '../../domain/usecases/get_top_rated.dart';
import 'movies_event.dart';
import 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetNowPlayingUseCase getNowPlayingUseCase;
  final GetPopularUseCase getPopularUseCase;
  final GetTopRatedUseCase getTopRatedUseCase;



  MoviesBloc(this.getNowPlayingUseCase, this.getPopularUseCase,
      this.getTopRatedUseCase )
      : super(const MoviesState()) {
    on<GetNowPlayingEvent>(_getNowPlayingMovies);
    on<GetPopularMoviesEvent>(_getPopularMovies);
    on<GetTopRatedMoviesEvent>(_getTopRatedMovies);

  }

  FutureOr<void> _getNowPlayingMovies(GetNowPlayingEvent event, Emitter<MoviesState> emit)async {
    final result = await getNowPlayingUseCase.call(const NoParameters());
    result.fold(
            (l) => emit(state.copyWith(
            nowPlayingState: RequestState.error,
            nowPlayingMessage: l.message)),
            (r) => emit(state.copyWith(
            nowPlayingMovies: r, nowPlayingState: RequestState.loaded)));
  }

  FutureOr<void> _getPopularMovies(GetPopularMoviesEvent event, Emitter<MoviesState> emit)async {
    final result = await getPopularUseCase.call(const NoParameters());
    result.fold(
            (l) => emit(state.copyWith(
            popularState: RequestState.error,
            popularMessage: l.message)),
            (r) => emit(state.copyWith(
            popularMovies: r, popularState: RequestState.loaded)));
  }

  FutureOr<void> _getTopRatedMovies(GetTopRatedMoviesEvent event, Emitter<MoviesState> emit)async {
    final result=await getTopRatedUseCase.call(const NoParameters());
    print(result);
    result.fold(
            (l) => emit(state.copyWith(
            topRatedState: RequestState.error,
            topRatedMessage: l.message)),
            (r) => emit(state.copyWith(
            topRatedMovies: r, topRatedState: RequestState.loaded)));

  }


}
