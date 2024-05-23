// ignore_for_file: avoid_print
import 'package:anime_guid_2/models/anime_json.dart';
import 'package:anime_guid_2/provider/top_anime_web_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GenresAnimeWebServicesNotifier extends StateNotifier<List<Data>> {
  GenresAnimeWebServicesNotifier() : super([]);

  Future<void> fetchGenresAnime(int page, {int genresId = 0}) async {
    try {
      final response = await dio.get('/anime?genres=$genresId&page=$page');
      if (response.statusCode == 200) {
        final AnimeJson genresAnime = AnimeJson.fromJson(response.data);
        if (page == 1) {
          state = genresAnime.data;
          // print(state.toString());
        } else {
          state = [...state, ...genresAnime.data];
        }
      } else {
        print('Failed to load top anime');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> clearGenerAnimeList() async {
    state = [];
  }
}

final genresAnimeWebServicesProvider2 =
    StateNotifierProvider<GenresAnimeWebServicesNotifier, List<Data>>(
  (ref) => GenresAnimeWebServicesNotifier(),
);
