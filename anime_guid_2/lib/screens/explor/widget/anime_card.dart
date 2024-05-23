// anime_widgets.dart
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:anime_guid_2/models/anime_json.dart';
import 'package:anime_guid_2/pages/anime_details_page.dart';

Widget buildAnimeGrid(List<Data> animeList, Function(Data) onTap) {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      childAspectRatio: 2 / 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    ),
    itemCount: animeList.length,
    itemBuilder: (context, index) {
      final anime = animeList[index];
      return buildAnimeCard(anime, onTap);
    },
  );
}

Widget buildAnimeCard(Data data, Function(Data) onTap) {
  return InkWell(
    onTap: () => onTap(data),
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
