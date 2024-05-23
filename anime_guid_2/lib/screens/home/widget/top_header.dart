// ignore_for_file: depend_on_referenced_packages, prefer_typing_uninitialized_variables
import 'package:anime_guid_2/config/theme/app_colors.dart';
import 'package:anime_guid_2/config/constants/image_route.dart';
import 'package:anime_guid_2/pages/anime_details_page.dart';
import 'package:anime_guid_2/provider/anime_seasons_web_services.dart';
import 'package:anime_guid_2/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class TopHeader extends ConsumerWidget {
  const TopHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animeList = ref.watch(animeSeasonsNowWebServicesNotifier);
    final shuffledAnimeList = List.from(animeList)..shuffle();
    final isDataLoaded = animeList.isNotEmpty;

    return SliverToBoxAdapter(
      child: Stack(
        children: [
          _TopImageSection(
            imageUrl: isDataLoaded
                ? shuffledAnimeList[0].images.values.first.largeImageUrl
                : 'assets/images/downloads/anime.jpg',
            isDataLoaded: isDataLoaded,
          ),
          const _TopIconsSection(),
          _BottomSection(
            isDataLoaded ? shuffledAnimeList[0].title : '',
            isDataLoaded ? shuffledAnimeList[0].score : 0.0,
            isDataLoaded ? shuffledAnimeList[0].malId : 1,
            isDataLoaded ? shuffledAnimeList[0] : [],
          )
        ],
      ),
    );
  }
}

class _TopIconsSection extends ConsumerWidget {
  const _TopIconsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme colorTheme = ref.watch(themeProvider);
    final isDarkTheme = colorTheme.brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 64),
      child: Row(
        children: [
          SvgPicture.asset(AppImagesRoute.appLogo),
          const Spacer(),
          TextButton(
            onPressed: () {
              ref.watch(themeProvider.notifier).changeTheme();
            },
            child: Icon(
              isDarkTheme ? Icons.wb_sunny : Icons.nightlight_round,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}

class _TopImageSection extends StatelessWidget {
  const _TopImageSection({
    required this.imageUrl,
    required this.isDataLoaded,
  });

  final String imageUrl;
  final bool isDataLoaded;

  @override
  Widget build(BuildContext context) {
    if (!isDataLoaded) {
      return const SizedBox(); // Return an empty container or placeholder widget if data is not loaded
    }

    final screenHeight = MediaQuery.of(context).size.height;
    const designHeight = 926.0;
    const imageHeight = 400.0;
    final heightRatio = screenHeight / designHeight;
    final responsiveImageHeight = heightRatio * imageHeight;

    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        begin: FractionalOffset.bottomLeft,
        end: FractionalOffset.center,
        colors: [
          Color(0xff181A20),
          Colors.white,
        ],
      ).createShader(bounds),
      blendMode: BlendMode.modulate,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        height: responsiveImageHeight,
        width: double.infinity,
      ),
    );
  }
}

class _BottomSection extends StatelessWidget {
  const _BottomSection(
      this.name, this.score, this.anime, this.shuffledAnimeList);
  final String name;
  final double score;
  final int? anime;
  final shuffledAnimeList;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Positioned(
      bottom: 24,
      left: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: theme.textTheme.bodyMedium!.copyWith(color: AppColors.white),
          ),
          const SizedBox(height: 8),
          Text(
            'Action, Superhero, Science Fiction, ...',
            style: theme.textTheme.bodySmall!
                .copyWith(color: AppColors.white, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 32,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  onPressed: () {},
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star_border_purple500_sharp,
                        color: Colors.yellowAccent,
                      ),
                      //  SvgPicture.asset(AppImagesRoute.iconPrivacy),
                      const SizedBox(width: 8),
                      Text(
                        score.toString(),
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                height: 32,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: AppColors.white, width: 2),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          AnimeDetailsPage(animeList: shuffledAnimeList),
                    ));
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.info_outline_rounded,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        'More Info',
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
