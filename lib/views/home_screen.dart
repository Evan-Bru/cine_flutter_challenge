import 'package:flutter/material.dart';

import '../controllers/movie_controller.dart';
import '../core/colors/app_colors.dart';
import '../core/fonts/app_fonts.dart';
import '../models/movie_model.dart';
import '../widgets/cine_stream_logo.dart';
import '../widgets/home/featured_movie_card.dart';
import '../widgets/home/home_app_bar.dart';
import '../widgets/home/movie_poster_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MovieController controller = MovieController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool isSearchOpen = false;

  @override
  void initState() {
    super.initState();
    controller.getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() {
          isSearchOpen = false;
        });
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        backgroundColor: AppColors.darkBlue,
        body: SafeArea(
          child: ValueListenableBuilder<bool>(
            valueListenable: controller.isLoading,
            builder: (context, isLoading, child) {
              if (isLoading) {
                return const Column(
                  mainAxisAlignment: .center,
                  children: [
                    CineStreamLogo(),
                    SizedBox(height: 24),
                    CircularProgressIndicator(
                      color: AppColors.intenseRed,
                    ),
                  ],
                );
              }

              final error = controller.errorMessage.value;

              if (error != null) {
                return Center(
                  child: Padding(
                    padding: const .all(24),
                    child: Text(
                      error,
                      textAlign: TextAlign.center,
                      style: AppFonts.roboto(
                        color: AppColors.nougat,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              }

              return ValueListenableBuilder<List<MovieModel>>(
                valueListenable: controller.movies,
                builder: (context, movies, child) {
                  if (movies.isEmpty) {
                    return Center(
                      child: Text(
                        'Nenhum filme encontrado.',
                        style: AppFonts.roboto(
                          color: AppColors.nougat,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }

                  final MovieModel featuredMovie = movies.first;

                  return SingleChildScrollView(
                    child: Padding(
                      padding: const .symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),
                          HomeAppBar(
                            isSearchOpen: isSearchOpen,
                            onOpenSearch: () {
                              setState(() {
                                isSearchOpen = true;
                              });
                            },
                          ),
                          const SizedBox(height: 18),
                          FeaturedMovieCard(movie: featuredMovie),
                          const SizedBox(height: 24),
                          Text(
                            'Populares no momento',
                            style: AppFonts.roboto(
                              color: AppColors.isabelline,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          MoviePosterList(movies: movies),
                          const SizedBox(height: 24),
                          Text(
                            'Assistir depois',
                            style: AppFonts.roboto(
                              color: AppColors.isabelline,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          MoviePosterList(movies: movies),
                          const SizedBox(height: 24),
                          Text(
                            'Bem avaliados',
                            style: AppFonts.roboto(
                              color: AppColors.isabelline,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          MoviePosterList(movies: movies),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
