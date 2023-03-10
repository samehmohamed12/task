import 'package:dio/dio.dart';


import '../../../core/error/exception.dart';
import '../../../core/network/api_constance.dart';
import '../../../core/network/error_message.dart';
import '../../domain/usecases/get_movie_detail.dart';
import '../../domain/usecases/get_recommendation.dart';
import '../model/movie_detail.dart';
import '../model/movies.dart';
import '../model/recommendation.dart';

// c3435cfe40aeb079689227d82bf921d3
abstract class BaseMovieRemoteDataSource{
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future< MovieDetailModel> getMovieDetail(MovieDetailsParameters parameters);
  Future< List<RecommendationModel>> getRecommendation(RecommendationParameters parameters);
}
class MovieRemoteDataSource extends BaseMovieRemoteDataSource{
  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    final response = await Dio().get(
        ApiConstance.nowPlayingMoviesPath);

    if (response.statusCode == 200) {
      return List<MovieModel>.from((response.data['results'] as List)
          .map((e) => MovieModel.fromJson(e)));
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies()async {
    final response=await Dio().get(ApiConstance.popularMoviesPath);
    if(response.statusCode==200){
      return List<MovieModel>.from((response.data['results']as List).map((e) => MovieModel.fromJson(e)));
    }else{
      throw ServerException(errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }

  }

  @override
  Future<List<MovieModel>> getTopRatedMovies()async {
    final response = await Dio().get(ApiConstance.topRatedMoviesPath);
    if(response.statusCode==200){
      return List<MovieModel>.from((response.data['results']as List).map((e) => MovieModel.fromJson(e)));
    }else{
      throw ServerException(errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
     
  }

  @override
  Future< MovieDetailModel > getMovieDetail(MovieDetailsParameters parameters)async {
    final response = await Dio().get(ApiConstance.detailMoviePath(parameters.movieId));
    if(response.statusCode==200){
     return MovieDetailModel.fromJson(response.data);
    }else{
      throw ServerException(errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<RecommendationModel>> getRecommendation(RecommendationParameters parameters)async {
    final response = await Dio().get(ApiConstance.recommendationPath(parameters.id));
    if(response.statusCode==200){
      return List<RecommendationModel>.from((response.data['results']as List).map((e) => RecommendationModel.fromJson(e)));
    }else{
      throw ServerException(errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }
}
