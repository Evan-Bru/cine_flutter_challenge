import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/movie_model.dart';

class MovieController {
  final String baseUrl = 'https://api.themoviedb.org/3';

  final ValueNotifier<List<MovieModel>> movies = ValueNotifier([]);
  final ValueNotifier<MovieModel?> selectedMovie = ValueNotifier(null);

  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<String?> errorMessage = ValueNotifier(null);

  String get apiKey => dotenv.env['TMDB_API_KEY'] ?? '';

  Future<void> getPopularMovies() async {
    isLoading.value = true;
    errorMessage.value = null;

    if (apiKey.isEmpty) {
      errorMessage.value = 'API Key não encontrada.';
      isLoading.value = false;
      return;
    }

    try {
      final url = Uri.parse(
        '$baseUrl/movie/popular?api_key=$apiKey&language=pt-BR',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final List results = data['results'] ?? [];

        movies.value = results.map((movieJson) => MovieModel.fromJson(movieJson)).toList();
      } else {
        errorMessage.value = 'Erro ao buscar filmes populares. Código: ${response.statusCode}';
      }
    } catch (error) {
      errorMessage.value = 'Erro inesperado ao carregar filmes.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getMovieDetails(int movieId) async {
    isLoading.value = true;
    errorMessage.value = null;
    selectedMovie.value = null;

    if (apiKey.isEmpty) {
      errorMessage.value = 'API Key não encontrada.';
      isLoading.value = false;
      return;
    }

    try {
      final url = Uri.parse(
        '$baseUrl/movie/$movieId?api_key=$apiKey&language=pt-BR',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        selectedMovie.value = MovieModel.fromJson(data);
      } else {
        errorMessage.value = 'Erro ao buscar detalhes do filme. Código: ${response.statusCode}';
      }
    } catch (error) {
      errorMessage.value = 'Erro inesperado ao carregar detalhes do filme.';
    } finally {
      isLoading.value = false;
    }
  }
}
