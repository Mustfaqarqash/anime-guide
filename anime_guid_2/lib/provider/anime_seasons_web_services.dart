// ignore_for_file: avoid_print

import 'package:anime_guid_2/models/anime_json.dart';
import 'package:anime_guid_2/provider/top_anime_web_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimeSeasonsNowWebServicesNotifier extends StateNotifier<List<Data>> {
  AnimeSeasonsNowWebServicesNotifier() : super([]);

  Future<void> fetchTopAnime(int page) async {
    try {
      final response = await dio.get('/seasons/now?page=$page');
      if (response.statusCode == 200) {
        final AnimeJson topAnime = AnimeJson.fromJson(response.data);
        if (page == 1) {
          state = topAnime.data;
        } else {
          state = [...state, ...topAnime.data];
        }
      } else {
        print('Failed to load top anime');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}

final animeSeasonsNowWebServicesNotifier =
    StateNotifierProvider<AnimeSeasonsNowWebServicesNotifier, List<Data>>(
  (ref) => AnimeSeasonsNowWebServicesNotifier(),
);
