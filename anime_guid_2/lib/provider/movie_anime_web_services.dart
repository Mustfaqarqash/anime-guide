// ignore_for_file: avoid_print
import 'package:anime_guid_2/models/anime_json.dart';
import 'package:anime_guid_2/provider/top_anime_web_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieAnimeWebServicesNotifier extends StateNotifier<List<Data>> {
  MovieAnimeWebServicesNotifier() : super([]);

  Future<void> fetchTopAnime(int page) async {
    const maxRetries = 1000;
    int retries = 0;

    while (retries < maxRetries) {
      try {
        await Future.delayed(const Duration(seconds: 3));

        final response = await dio.get('anime/?type=movie&page=$page');
        if (response.statusCode == 200) {
          final AnimeJson topAnime = AnimeJson.fromJson(response.data);
          if (page == 1) {
            state = topAnime.data;
          } else {
            state = [...state, ...topAnime.data];
          }
          return; // Success, exit the loop
        } else if (response.statusCode == 429) {
          // If 429, wait and then retry
          await Future.delayed(
              const Duration(seconds: 5)); // Wait for 5 seconds
        } else {
          print(
              'Failed to load top anime. Status code: ${response.statusCode}');
          return; // Exit the loop on other errors
        }
      } catch (error) {
        print('Error: $error');
        return; // Exit the loop on errors
      }

      retries++;
    }

    print('Failed to load top anime after $maxRetries retries');
  }
}

final movieAnimeWebServicesProvider =
    StateNotifierProvider<MovieAnimeWebServicesNotifier, List<Data>>(
  (ref) => MovieAnimeWebServicesNotifier(),
);
