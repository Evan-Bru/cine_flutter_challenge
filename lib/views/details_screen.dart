import 'package:flutter/material.dart';

import '../controllers/movie_controller.dart';
import '../core/colors/app_colors.dart';
import '../core/fonts/app_fonts.dart';
import '../models/movie_model.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final MovieController controller = MovieController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool _didLoadMovie = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_didLoadMovie) {
      final movieId = ModalRoute.of(context)!.settings.arguments as int;

      controller.getMovieDetails(movieId);

      _didLoadMovie = true;
    }
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
                    textAlign: .center,
                    style: AppFonts.roboto(
                      color: AppColors.nougat,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            }

            return ValueListenableBuilder<MovieModel?>(
              valueListenable: controller.selectedMovie,
              builder: (context, movie, child) {
                if (movie == null) {
                  return Center(
                    child: Text(
                      'Filme não encontrado.',
                      style: AppFonts.roboto(
                        color: AppColors.nougat,
                        fontSize: 16,
                      ),
                    ),
                  );
                }

                return SingleChildScrollView(
                  child: Padding(
                    padding: const .symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        const SizedBox(height: 18),

                        _Header(),

                        const SizedBox(height: 18),

                        _BackdropImage(movie: movie),

                        const SizedBox(height: 18),

                        Text(
                          movie.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppFonts.fraunces(
                            color: AppColors.nougat,
                            fontSize: 22,
                            fontWeight: .w700,
                          ),
                        ),

                        const SizedBox(height: 10),

                        _MovieInfoRow(movie: movie),

                        const SizedBox(height: 26),

                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.play_arrow,
                                  size: 18,
                                ),
                                label: Text(
                                  'Assistir Agora',
                                  style: AppFonts.roboto(
                                    color: AppColors.nougat,
                                    fontWeight: .w500,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.intenseRed,
                                  foregroundColor: AppColors.nougat,
                                  padding: const .symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 16),

                            Container(
                              height: 52,
                              width: 52,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.transparentNougat08,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.bookmark_border,
                                color: AppColors.nougat,
                                size: 18,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        Text(
                          movie.overview.isNotEmpty ? movie.overview : 'Sinopse não disponível.',
                          style: AppFonts.roboto(
                            color: AppColors.nougat,
                            fontSize: 14,
                            height: 1.45,
                          ),
                        ),

                        const SizedBox(height: 28),

                        _InfoSection(
                          title: 'Produtoras:',
                          value: movie.productionCompanies.isNotEmpty
                              ? movie.productionCompanies.join(', ')
                              : 'Não informado',
                        ),

                        const SizedBox(height: 24),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _InfoSection(
                                title: 'Orçamento:',
                                value: _formatMoney(movie.budget),
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: _InfoSection(
                                title: 'Bilheteria:',
                                value: _formatMoney(movie.revenue),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        _InfoSection(
                          title: 'Idiomas:',
                          value: movie.spokenLanguages.isNotEmpty ? movie.spokenLanguages.join(', ') : 'Não informado',
                        ),

                        const SizedBox(height: 24),

                        _InfoSection(
                          title: 'Gêneros:',
                          value: movie.genres.isNotEmpty ? movie.genres.join(', ') : 'Não informado',
                        ),

                        const SizedBox(height: 32),
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

  static String _getReleaseYear(String releaseDate) {
    if (releaseDate.length >= 4) {
      return releaseDate.substring(0, 4);
    }

    return 'Ano não informado';
  }

  static String _formatMoney(int value) {
    if (value <= 0) {
      return 'Não informado';
    }

    final millions = value / 1000000;

    return 'US\$ ${millions.toStringAsFixed(0)} milhões';
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Cine',
                style: AppFonts.fraunces(
                  color: AppColors.intenseRed,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
              ),
              TextSpan(
                text: 'Stream',
                style: AppFonts.fraunces(
                  color: AppColors.nougat,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search,
            color: AppColors.mediumGray,
            size: 20,
          ),
        ),
      ],
    );
  }
}

class _BackdropImage extends StatelessWidget {
  final MovieModel movie;

  const _BackdropImage({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(2),
      child: Image.network(
        movie.backdropUrl,
        width: double.infinity,
        height: 185,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: double.infinity,
            height: 185,
            color: AppColors.transparentNougat08,
            child: const Icon(
              Icons.broken_image,
              color: AppColors.mediumGray,
            ),
          );
        },
      ),
    );
  }
}

class _MovieInfoRow extends StatelessWidget {
  final MovieModel movie;

  const _MovieInfoRow({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final year = _DetailsScreenState._getReleaseYear(movie.releaseDate);

    return Row(
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
          year,
          style: AppFonts.roboto(
            color: AppColors.transparentNougat60,
            fontSize: 12,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            movie.genres.isNotEmpty ? movie.genres.join(', ') : 'Gênero não informado',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppFonts.roboto(
              color: AppColors.transparentNougat60,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          movie.runtime > 0 ? '${movie.runtime}m' : '--',
          style: AppFonts.roboto(
            color: AppColors.transparentNougat60,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _InfoSection extends StatelessWidget {
  final String title;
  final String value;

  const _InfoSection({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppFonts.roboto(
            color: AppColors.nougat,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: AppFonts.roboto(
            color: AppColors.transparentNougat60,
            fontSize: 13,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
