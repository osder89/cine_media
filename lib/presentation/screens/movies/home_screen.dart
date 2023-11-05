import 'package:cine_media/presentation/providers/movies/movies_repository_provider.dart';
import 'package:cine_media/presentation/providers/movies/movies_slideshow_providers.dart';
import 'package:cine_media/presentation/widgets/movie/movie_horizontal_listview.dart';
import 'package:cine_media/presentation/widgets/shared/custom_appbar.dart';
import 'package:cine_media/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/movies/initial_loading_provider.dart';
import '../../providers/movies/movies_providers.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigator(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMovieProvider.notifier).loadNextPage();
    ref.read(upcomingMovieProvider.notifier).loadNextPage();
    ref.read(topratedMovieProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoaadingProvider);
    if (initialLoading) return const FullScreenLoader();
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMovieProvider);
    final upcomingMovies = ref.watch(upcomingMovieProvider);
    final toprated = ref.watch(topratedMovieProvider);
    final slideShow = ref.watch(moviesSlideshowProvider);

    return Visibility(
      visible: !initialLoading,
      child: CustomScrollView(slivers: [
        SliverAppBar(
          floating: true,
          title: CustomAppBar(),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Column(
              children: [
                const CustomAppBar(),
                MovieSlideshow(movies: slideShow),
                MovieHorizontalLisstview(
                    movies: nowPlayingMovies,
                    title: 'En Cartelera',
                    subtitle: 'Lunes 20',
                    loadNextPage: () {
                      ref
                          .read(nowPlayingMoviesProvider.notifier)
                          .loadNextPage();
                    }),
                MovieHorizontalLisstview(
                    movies: popularMovies,
                    title: 'Populares',
                    //subtitle: 'Lunes 20',
                    loadNextPage: () {
                      ref.read(popularMovieProvider.notifier).loadNextPage();
                    }),
                MovieHorizontalLisstview(
                    movies: upcomingMovies,
                    title: 'Proximanente',
                    subtitle: 'Este mes',
                    loadNextPage: () {
                      ref.read(upcomingMovieProvider.notifier).loadNextPage();
                    }),
                MovieHorizontalLisstview(
                    movies: toprated,
                    title: 'Mejor Calificadas',
                    subtitle: 'De siempre',
                    loadNextPage: () {
                      ref.read(topratedMovieProvider.notifier).loadNextPage();
                    }),
                const SizedBox(height: 10),
              ],
            );
          },
          childCount: 1,
        ))
      ]),
    );
  }
}
