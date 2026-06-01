import 'package:flutter/material.dart';

import '../controllers/movie_controller.dart';
import '../core/colors/app_colors.dart';
import '../core/fonts/app_fonts.dart';
import '../core/gradients/app_gradients.dart';
import '../models/movie_model.dart';
import '../widgets/cine_stream_logo.dart';
import '../widgets/details/details_backdrop_image.dart';
import '../widgets/details/details_header.dart';
import '../widgets/details/info_section.dart';
import '../widgets/details/movie_info_row.dart';

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
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      const Padding(
                        padding: .symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            DetailsHeader(),
                            SizedBox(height: 12),
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          DetailsBackdropImage(movie: movie),
                          Positioned.fill(
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: AppGradients.detailsImageOverlay,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 25,
                            right: 38,
                            bottom: 0,
                            child: Text(
                              movie.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppFonts.fraunces(
                                color: AppColors.nougat,
                                fontSize: 24,
                                fontWeight: .w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      Padding(
                        padding: const .fromLTRB(25, 1, 40, 4),
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            const SizedBox(height: 10),

                            MovieInfoRow(movie: movie),

                            const SizedBox(height: 26),

                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.play_arrow,
                                      size: 24,
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
                                      padding: const .fromLTRB(9, 16, 9, 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: .circular(16),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 30),
                                Container(
                                  height: 57,
                                  width: 57,
                                  decoration: BoxDecoration(
                                    border: .all(
                                      color: AppColors.transparentNougat08,
                                    ),
                                    borderRadius: .circular(16),
                                  ),
                                  child: const Icon(
                                    Icons.bookmark_border,
                                    color: AppColors.nougat,
                                    size: 20,
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

                            InfoSection(
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
                                  child: InfoSection(
                                    title: 'Orçamento:',
                                    value: _formatMoney(movie.budget),
                                  ),
                                ),
                                const SizedBox(width: 24),
                                Expanded(
                                  child: InfoSection(
                                    title: 'Bilheteria:',
                                    value: _formatMoney(movie.revenue),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 24),

                            InfoSection(
                              title: 'Idiomas:',
                              value: movie.spokenLanguages.isNotEmpty
                                  ? movie.spokenLanguages.join(', ')
                                  : 'Não informado',
                            ),

                            const SizedBox(height: 24),

                            InfoSection(
                              title: 'Gêneros:',
                              value: movie.genres.isNotEmpty ? movie.genres.join(', ') : 'Não informado',
                            ),

                            const SizedBox(height: 32),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  static String _formatMoney(int value) {
    if (value <= 0) {
      return 'Não informado';
    }

    final millions = value / 1000000;

    return 'US\$ ${millions.toStringAsFixed(0)} milhões';
  }
}
