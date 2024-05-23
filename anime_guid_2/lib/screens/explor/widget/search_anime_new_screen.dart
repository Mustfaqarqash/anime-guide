// ignore_for_file: deprecated_member_use
import 'package:anime_guid_2/config/constants/image_route.dart';
import 'package:anime_guid_2/config/theme/app_colors.dart';
import 'package:anime_guid_2/models/anime_json.dart';
import 'package:anime_guid_2/provider/search_anime_web_services.dart';
import 'package:anime_guid_2/screens/explor/widget/anime_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class SearchAnimeNewScreen extends ConsumerStatefulWidget {
  const SearchAnimeNewScreen({super.key});

  @override
  ConsumerState<SearchAnimeNewScreen> createState() =>
      _SearchAnimeNewScreenState();
}

class _SearchAnimeNewScreenState extends ConsumerState<SearchAnimeNewScreen> {
  late final TextEditingController _searchController;
  final FocusNode searchFocusNode = FocusNode();
  @override
  void initState() {
    searchFocusNode.addListener(() {
      setState(() {});
    });
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchFocusNode.dispose();
    _searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var textSearchAnimeList = ref.watch(searchAnimeWebServicesProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_sharp,
            color: Colors.red,
          ),
        ),
        title: AnimatedContainer(
          width: double.infinity,
          duration: const Duration(milliseconds: 500),
          //height: 56,
          decoration: BoxDecoration(
            // color: AppColors.dark2,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: searchFocusNode.hasFocus
                  ? theme.primaryColor
                  : const Color.fromARGB(255, 55, 58, 66),
              width: 1,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
            autofocus: true,
            focusNode: searchFocusNode,
            style: theme.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w600, color: AppColors.white),
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: 'Search',
              hintStyle: theme.textTheme.bodyMedium!.copyWith(
                  color: AppColors.grey600, fontWeight: FontWeight.w500),
              icon: SvgPicture.asset(
                AppImagesRoute.iconSearch,
                color: searchFocusNode.hasFocus
                    ? theme.primaryColor
                    : AppColors.grey600,
              ),
            ),
            onChanged: (e) {
              ref.watch(searchAnimeWebServicesProvider.notifier).searchAnime(e);
            },
          ),
        ),
      ),
      body: Column(
        children: [
          // Use Expanded to ensure the body takes the remaining space
          Expanded(
            child: _buildBodyAnime(textSearchAnimeList),
          ),
        ],
      ),
    );
  }

  Widget _buildBodyAnime(List<Data> textSearchAnimeList) {
    var animeList = textSearchAnimeList;

    return animeList.isEmpty
        ? Center(
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Image.asset('assets/images/empty_list_dark.png'),
            ),
          )
        : buildAnimeGrid(animeList, _navigateToAnimeDetailsPage);
  }

  void _navigateToAnimeDetailsPage(Data data) {
    navigateToAnimeDetailsPage(context, data);
  }
}
