 import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/network/api_constance.dart';
import '../../../core/services/services_locator.dart';
import '../../../core/utilis/app_sizes.dart';
import '../../../core/utilis/enums.dart';
import '../controller/movies_bloc.dart';
import '../controller/movies_event.dart';
import '../controller/movies_state.dart';
import 'movie_detail_screen.dart';


class PopularScreen extends StatelessWidget {
  const PopularScreen({Key? key}) : super(key: key);
  static double widthSmall = 130.w;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: BlocProvider(
          create: (BuildContext context) =>
              sl<MoviesBloc>()..add(GetPopularMoviesEvent()),
          child: BlocBuilder<MoviesBloc, MoviesState>(
            builder: (context, state) {
              final popular = state.popularMovies;
              switch (state.popularState) {
                case RequestState.loading:
                  return const SizedBox(
                    height: 400.0,
                    child: Center(child: CircularProgressIndicator()),
                  );
                case RequestState.loaded:
                  return GridView.count(
                    physics: const BouncingScrollPhysics(),
                    crossAxisCount: 1,
                    childAspectRatio: 2,
                    mainAxisSpacing: 3,
                    crossAxisSpacing: 2,
                    children: List.generate(
                      state.popularMovies.length,
                      (index) => InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MovieDetailScreen(
                                          id: popular[index].id)));
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              width: 230,
                              imageUrl: ApiConstance.imageUrl(
                                  popular[index].backdropPath),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.cover,
                              height: 200.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: AppSizes.widthSmall,
                                    child: Text(
                                      popular[index].title,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(fontSize: 22),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    popular[index].releaseDate.split('-')[0],
                                    style: const TextStyle(
                                      fontSize: 23.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 20.0,
                                      ),
                                      const SizedBox(width: 4.0),
                                      Text(
                                        (popular[index].voteAverage / 2)
                                            .toStringAsFixed(1),
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                      const SizedBox(width: 4.0),
                                      Text(
                                        '(${popular[index].voteAverage})',
                                        style: const TextStyle(
                                          fontSize: 1.0,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );

                case RequestState.error:
                  return const SizedBox(
                    height: 400.0,
                    child: Center(child: CircularProgressIndicator()),
                  );
              }
            },
          )),
    );
  }
}
