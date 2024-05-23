// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:anime_guid_2/config/constants/image_route.dart';
import 'package:anime_guid_2/models/anime_json.dart';
import 'package:anime_guid_2/models/anime_type_json.dart';
import 'package:anime_guid_2/provider/anime_genars_rovider.dart';
import 'package:anime_guid_2/provider/anime_genres.dart';
import 'package:anime_guid_2/screens/explor/widget/anime_card_whith_controll.dart';
import 'package:anime_guid_2/screens/explor/widget/search_anime_new_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class SearchAnimePage extends ConsumerStatefulWidget {
  const SearchAnimePage({super.key});

  @override
  _SearchAnimePageState createState() => _SearchAnimePageState();
}

class _SearchAnimePageState extends ConsumerState<SearchAnimePage> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    ref.read(genresAnimeWebServicesProvider.notifier).fetchAnimeGenres();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animeGenre = ref.watch(genresAnimeWebServicesProvider);
    final generAnimeList = ref.watch(genresAnimeWebServicesProvider2);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Anime By Genres',
          style: TextStyle(fontSize: 17, color: Colors.red),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const SearchAnimeNewScreen(),
                ),
              );
              ref
                  .read(genresAnimeWebServicesProvider2.notifier)
                  .clearGenerAnimeList();
            },
            icon: SvgPicture.asset(
              AppImagesRoute.iconSearch,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildAnimeGenreButtons(animeGenre),
          Expanded(
            child: _buildBodyAnime(generAnimeList),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimeGenreButtons(List<AnimeTypeData> animeGenre) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: animeGenre.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                final selectedGenreId = animeGenre[index].malId ?? 0;
                ref
                    .watch(genresAnimeWebServicesProvider2.notifier)
                    .fetchGenresAnime(1, genresId: selectedGenreId);
              },
              child: Text(animeGenre[index].name ?? ''),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBodyAnime(List<Data> generAnimeList) {
    return generAnimeList.isEmpty
        ? Center(
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Image.asset('assets/images/empty_list_dark.png'),
            ),
          )
        : const AnimeGridController();
  }
}
