// ignore_for_file: avoid_print
import 'package:anime_guid_2/models/anime_type_json.dart';
import 'package:anime_guid_2/provider/top_anime_web_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GenresAnimeWebServicesNotifier
    extends StateNotifier<List<AnimeTypeData>> {
  GenresAnimeWebServicesNotifier() : super([]);

  Future<void> fetchAnimeGenres() async {
    try {
      final response = await dio.get('/genres/anime');
      if (response.statusCode == 200) {
        final AnimeGenre genres = AnimeGenre.fromJson(response.data);
        state = genres.data!;
        // print('Fetched anime genres');
        // print('Fetched anime genres: $state');
      } else {
        print(
            'Failed to load anime genres. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching anime genres: $error');
    }
  }
}

final genresAnimeWebServicesProvider =
    StateNotifierProvider<GenresAnimeWebServicesNotifier, List<AnimeTypeData>>(
  (ref) => GenresAnimeWebServicesNotifier(),
);
