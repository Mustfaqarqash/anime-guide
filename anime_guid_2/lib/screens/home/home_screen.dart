import 'package:anime_guid_2/listes/anime_seasons_now_list.dart';
import 'package:anime_guid_2/listes/movie_anime_list.dart';
import 'package:anime_guid_2/listes/top_anime_list.dart';
import 'package:anime_guid_2/screens/home/widget/movie_list_title.dart';
import 'package:anime_guid_2/screens/home/widget/top_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          TopHeader(),
          SliverToBoxAdapter(child: SizedBox(height: 20)),
          MovieListTitle(title: 'Top Anime '),
          TopAnimeScreen(),
          SliverToBoxAdapter(child: SizedBox(height: 20)),
          MovieListTitle(title: 'Anime in This Seasons'),
          AnimeSeasonsNow(),
          SliverToBoxAdapter(child: SizedBox(height: 20)),
          MovieListTitle(title: 'Anime Movie'),
          MovieAnimeScreen(),
          // MovieListTitle(title: 'Anime Ova'),
          // MovieAnimeScreen('ova'),
          // MovieListTitle(title: 'Anime special'),
          // MovieAnimeScreen('special'),
          // MovieListTitle(title: 'Anime Ona'),
          // MovieAnimeScreen('ona'),
          // MovieListTitle(title: 'Anime Music'),
          // MovieAnimeScreen('music'),
          SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}
