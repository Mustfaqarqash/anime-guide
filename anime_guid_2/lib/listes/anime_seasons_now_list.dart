import 'package:anime_guid_2/models/anime_json.dart';
import 'package:anime_guid_2/pages/anime_details_page.dart';
import 'package:anime_guid_2/provider/anime_seasons_web_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transparent_image/transparent_image.dart';

class AnimeSeasonsNow extends ConsumerStatefulWidget {
  const AnimeSeasonsNow({super.key});

  @override
  ConsumerState<AnimeSeasonsNow> createState() => _TopAnimeState();
}

class _TopAnimeState extends ConsumerState<AnimeSeasonsNow> {
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
            .read(animeSeasonsNowWebServicesNotifier.notifier)
            .fetchTopAnime(currentPage);
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final animeList = ref.watch(animeSeasonsNowWebServicesNotifier);

    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200,
        width: double.infinity,
        child:
            animeList.isEmpty ? _buildEmptyState() : _buildAnimeGrid(animeList),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: isLoading
          ? const CircularProgressIndicator()
          : const Text('No anime data available.'),
    );
  }

  Widget _buildAnimeGrid(List<Data> animeList) {
    return GridView.builder(
      scrollDirection: Axis.horizontal,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 1.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: animeList.length,
      itemBuilder: (context, index) {
        final anime = animeList[index];
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AnimeDetailsPage(animeList: anime),
            ));
          },
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
                      Hero(
                        tag: 'animeDetail${anime.malId}',
                        child: FadeInImage(
                          placeholder: MemoryImage(kTransparentImage),
                          image:
                              NetworkImage(anime.images.values.first.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Row(
                            children: [
                              const Icon(Icons.star_border_purple500,
                                  size: 15, color: Colors.yellow),
                              Text(
                                anime.score.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // const Icon(Icons.timer_sharp),
                          Expanded(
                            child: Text(
                              anime.title,
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
        );
      },
      controller: _scrollController,
    );
  }
}
