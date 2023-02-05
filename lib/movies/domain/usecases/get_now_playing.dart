 import 'package:dartz/dartz.dart';


import '../../../core/error/failure.dart';
import '../../../core/usecase/base_usecase.dart';
import '../entities/movie.dart';
import '../repository/base_movies_repository.dart';

class GetNowPlayingUseCase extends BaseUseCase<List<Movie>,NoParameters>{
  final BaseMoviesRepository baseMoviesRepository;

  GetNowPlayingUseCase(this.baseMoviesRepository);
 @override
  Future<Either<Failure, List<Movie>>> call(NoParameters parameters)async{
    return await baseMoviesRepository.getNowPlayingMovies();


  }
}