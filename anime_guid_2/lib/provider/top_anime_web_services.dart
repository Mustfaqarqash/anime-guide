// ignore_for_file: avoid_print
import 'package:anime_guid_2/config/constants/strings.dart';
import 'package:anime_guid_2/models/anime_json.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Dio dio = Dio(BaseOptions(
  method: 'GET',
  baseUrl: baseUrl,
  receiveDataWhenStatusError: true,
  connectTimeout: const Duration(minutes: 10),
  receiveTimeout: const Duration(seconds: 10),
));

class TopAnimeWebServicesNotifier extends StateNotifier<List<Data>> {
  TopAnimeWebServicesNotifier() : super([]);

  Future<void> fetchTopAnime(int page) async {
    try {
      final response = await dio.get('/top/anime?page=$page');
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

final topAnimeWebServicesProvider =
    StateNotifierProvider<TopAnimeWebServicesNotifier, List<Data>>(
  (ref) => TopAnimeWebServicesNotifier(),
);
