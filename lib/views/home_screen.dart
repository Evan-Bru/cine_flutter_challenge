import 'package:flutter/material.dart';

import '../controllers/movie_controller.dart';
import '../models/movie_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MovieController controller = MovieController();

  @override
  void initState() {
    super.initState();
    controller.getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<bool>(
        valueListenable: controller.isLoading,
        builder: (context, isLoading, child) {
          if (isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final error = controller.errorMessage.value;

          if (error != null) {
            return Center(
              child: Text(error),
            );
          }

          return ValueListenableBuilder<List<MovieModel>>(
            valueListenable: controller.movies,
            builder: (context, movies, child) {
              if (movies.isEmpty) {
                return const Center(
                  child: Text('Nenhum filme encontrado.'),
                );
              }

              return Center(
                child: Text('Filmes carregados: ${movies.length}'),
              );
            },
          );
        },
      ),
    );
  }
}
