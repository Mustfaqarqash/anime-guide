// ignore_for_file: avoid_print
import 'package:anime_guid_2/models/anime_json.dart';
import 'package:anime_guid_2/provider/top_anime_web_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchAnimeWebServicesNotifier extends StateNotifier<List<Data>> {
  SearchAnimeWebServicesNotifier() : super([]);

  final List<String> _requestQueue = [];
  bool _isProcessingQueue = false;

  Future<void> _processQueue() async {
    _isProcessingQueue = true;
    while (_requestQueue.isNotEmpty) {
      final String query = _requestQueue.removeAt(0);
      await _performSearch(query);
      await Future.delayed(
          const Duration(milliseconds: 1000 ~/ 3)); // Adjust as needed
    }
    _isProcessingQueue = false;
  }

  Future<void> _performSearch(String query) async {
    try {
      final response = await dio.get('anime/?q=${query.toUpperCase()}');
      if (response.statusCode == 200) {
        final AnimeJson searchResults = AnimeJson.fromJson(response.data);
        state = searchResults.data;
      } else {
        state = [];
      }
    } catch (e) {
      // Handle error or log it
      print('Error: $e');
    }
  }

  Future<void> searchAnime(String query, {int retries = 0}) async {
    if (_isProcessingQueue) {
      _requestQueue.add(query);
    } else {
      await _performSearch(query);
    }
    if (!_isProcessingQueue) {
      _processQueue();
    }
  }
}

final searchAnimeWebServicesProvider =
    StateNotifierProvider<SearchAnimeWebServicesNotifier, List<Data>>(
  (ref) => SearchAnimeWebServicesNotifier(),
);
