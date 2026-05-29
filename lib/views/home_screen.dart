import 'package:flutter/material.dart';

import '../controllers/movie_controller.dart';
import '../core/colors/app_colors.dart';
import '../core/fonts/app_fonts.dart';
import '../models/movie_model.dart';
import '../routes/app_routes.dart';

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
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      body: SafeArea(
        child: ValueListenableBuilder<bool>(
          valueListenable: controller.isLoading,
          builder: (context, isLoading, child) {
            if (isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.intenseRed,
                ),
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
                        Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Cine',
                                    style: AppFonts.fraunces(
                                      color: AppColors.accentRed,
                                      fontSize: 24,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  const WidgetSpan(
                                    child: SizedBox(width: 2),
                                  ),
                                  TextSpan(
                                    text: 'Stream',
                                    style: AppFonts.fraunces(
                                      color: AppColors.nougat,
                                      fontSize: 24,
                                      letterSpacing: -0.9,
                                      height: 0.9,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 16),

                            Expanded(
                              child: isSearchOpen
                                  ? Container(
                                      height: 36,
                                      padding: const .symmetric(horizontal: 12),
                                      decoration: BoxDecoration(
                                        color: AppColors.softDarkBlue,
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.search,
                                            color: AppColors.mediumGray,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: TextField(
                                              style: AppFonts.roboto(
                                                color: AppColors.nougat,

                                                fontSize: 12,
                                              ),
                                              decoration: InputDecoration(
                                                hintText: 'Pesquisar filme',
                                                hintStyle: AppFonts.roboto(
                                                  color: AppColors.transparentNougat60,
                                                  fontSize: 12,
                                                ),
                                                border: InputBorder.none,
                                                isDense: true,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Align(
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isSearchOpen = true;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.search,
                                          color: AppColors.mediumGray,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 18),

                        _FeaturedMovieCard(movie: featuredMovie),

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

                        _MoviePosterList(movies: movies),

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

                        _MoviePosterList(movies: movies),

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

                        _MoviePosterList(movies: movies),

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
    );
  }
}

class _FeaturedMovieCard extends StatelessWidget {
  final MovieModel movie;

  const _FeaturedMovieCard({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: .circular(4),
        image: DecorationImage(
          image: NetworkImage(movie.backdropUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const .all(14),
        decoration: BoxDecoration(
          borderRadius: .circular(4),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withValues(alpha: 0.05),
              Colors.black.withValues(alpha: 0.35),
              Colors.black.withValues(alpha: 0.85),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: .end,
          crossAxisAlignment: .start,
          children: [
            Text(
              movie.title,
              maxLines: 2,
              overflow: .ellipsis,
              style: AppFonts.fraunces(
                color: AppColors.nougat,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 6),

            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: AppColors.transparentNougat60,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  movie.voteAverage.toStringAsFixed(1),
                  style: AppFonts.roboto(
                    color: AppColors.transparentNougat60,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  _getReleaseYear(movie.releaseDate),
                  style: AppFonts.roboto(
                    color: AppColors.transparentNougat60,
                    fontSize: 12,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.details,
                        arguments: movie.id,
                      );
                    },
                    icon: const Icon(
                      Icons.play_arrow,
                      size: 18,
                    ),
                    label: Text(
                      'Assistir Agora',
                      style: AppFonts.roboto(color: AppColors.nougat, fontWeight: .w500),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.intenseRed,
                      foregroundColor: AppColors.nougat,
                      padding: const .symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Container(
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.transparentNougat08,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.bookmark_border,
                    color: AppColors.nougat,
                    size: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static String _getReleaseYear(String releaseDate) {
    if (releaseDate.length >= 4) {
      return releaseDate.substring(0, 4);
    }

    return 'Ano não informado';
  }
}

class _MoviePosterList extends StatelessWidget {
  final List<MovieModel> movies;

  const _MoviePosterList({
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 155,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        separatorBuilder: (context, index) {
          return const SizedBox(width: 12);
        },
        itemBuilder: (context, index) {
          final movie = movies[index];

          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.details,
                arguments: movie.id,
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                movie.posterUrl,
                width: 100,
                height: 155,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 100,
                    height: 155,
                    color: AppColors.transparentNougat08,
                    child: const Icon(
                      Icons.broken_image,
                      color: AppColors.mediumGray,
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
