// ignore_for_file: avoid_print

import 'package:anime_guid_2/models/character_json.dart';
import 'package:anime_guid_2/provider/top_anime_web_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimeCharactersWebServicesNotifier extends StateNotifier<List<Datume>> {
  AnimeCharactersWebServicesNotifier() : super([]);

  Future<void> fetchCharacters(int animeId) async {
    try {
      final response = await dio.get('/anime/$animeId/characters');
      if (response.statusCode == 200) {
        final CharactersModel charactersModel =
            CharactersModel.fromJson(response.data);
        state = charactersModel.data;
      } else {
        print('Failed to load characters data');
      }
    } catch (error) {
      print('Errorrrrrrrrrr: $error');
    }
  }

  Future<void> willPopScope() async {
    state = [];
    state.remove;
  }
}

final animeCharactersWebServicesProvider =
    StateNotifierProvider<AnimeCharactersWebServicesNotifier, List<Datume>>(
  (ref) => AnimeCharactersWebServicesNotifier(),
);
