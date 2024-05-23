import 'package:anime_guid_2/models/character_json.dart';
import 'package:anime_guid_2/pages/character_details_page.dart';
import 'package:anime_guid_2/provider/charctaer_web_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transparent_image/transparent_image.dart';

class AnimeCharactersPage extends ConsumerStatefulWidget {
  final int animeId;

  const AnimeCharactersPage({super.key, required this.animeId});

  @override
  ConsumerState<AnimeCharactersPage> createState() =>
      _AnimeCharactersPageState();
}

class _AnimeCharactersPageState extends ConsumerState<AnimeCharactersPage> {
  late final AnimeCharactersWebServicesNotifier _animeCharactersNotifier;

  @override
  void initState() {
    super.initState();
    _animeCharactersNotifier =
        ref.read(animeCharactersWebServicesProvider.notifier);
    // Fetch characters data when the page is initialized
    _animeCharactersNotifier.fetchCharacters(widget.animeId);
  }

  @override
  Widget build(BuildContext context) {
    final charactersModel = ref.watch(animeCharactersWebServicesProvider);

    return SizedBox(
      height: 200,
      width: double.infinity,
      child: charactersModel.isNotEmpty
          ? GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1.5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: charactersModel.length,
              itemBuilder: (context, index) {
                final character = charactersModel[index];
                return _buildCharacterCard(character);
              },
            )
          : const Center(child: Text('No characters data available.')),
    );
  }

  Widget _buildCharacterCard(Datume character) {
    var character1 = character.character;
    // var characterRole = character.role;

    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ShowCharacterDetailsDialog(character: character);
        }));
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
                  FadeInImage(
                    placeholder: MemoryImage(kTransparentImage),
                    image:
                        NetworkImage(character1?.images!.jpg!.imageUrl ?? ''),
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.favorite,
                            size: 15,
                            color: Colors.pink,
                          ),
                          Text(
                            '${character.favorites ?? 'N/A'}',
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
                          'Name: ${character1?.name ?? 'N/A'}',
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
  }
}
