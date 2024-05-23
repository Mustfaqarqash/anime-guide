// ignore_for_file: library_private_types_in_public_api

import 'package:anime_guid_2/models/anime_json.dart';
import 'package:anime_guid_2/pages/anime_details_page.dart';
import 'package:anime_guid_2/provider/anime_genres.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transparent_image/transparent_image.dart';

class AnimeGridController extends ConsumerStatefulWidget {
  const AnimeGridController({super.key});

  @override
  _AnimeGridControllerState createState() => _AnimeGridControllerState();
}

class _AnimeGridControllerState extends ConsumerState<AnimeGridController> {
  int currentPage = 0;
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    // Initial data fetch
    _fetchData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchData();
    }
  }

  Future<void> _fetchData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        currentPage++;
      });

      try {
        await ref
            .watch(genresAnimeWebServicesProvider2.notifier)
            .fetchGenresAnime(currentPage);
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final animeList = ref.watch(genresAnimeWebServicesProvider2);

    return animeList.isEmpty ? _buildEmptyState() : buildAnimeGrid(animeList);
  }

  Widget _buildEmptyState() {
    return Center(
      child: isLoading
          ? const CircularProgressIndicator()
          : const Text('No anime data available.'),
    );
  }

  Widget buildAnimeGrid(List<Data> animeList) {
    return GridView.builder(
      controller: _scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: animeList.length,
      itemBuilder: (context, index) {
        final anime = animeList[index];
        return buildAnimeCard(anime);
      },
    );
  }

  Widget buildAnimeCard(Data data) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnimeDetailsPage(animeList: data),
          ),
        );
      },
      child: SizedBox(
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    FadeInImage(
                      placeholder: MemoryImage(kTransparentImage),
                      image: NetworkImage(data.images.values.first.imageUrl),
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star_border_purple500,
                            size: 15,
                            color: Colors.yellow,
                          ),
                          Text(
                            data.score.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            data.title,
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToAnimeDetailsPage(BuildContext context, Data data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnimeDetailsPage(animeList: data),
      ),
    );
  }
}
