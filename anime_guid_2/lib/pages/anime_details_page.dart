// ignore_for_file: deprecated_member_use
import 'package:anime_guid_2/listes/charctaers_list.dart';
import 'package:anime_guid_2/models/anime_json.dart';
import 'package:anime_guid_2/pages/you_tube_Player.dart';
import 'package:anime_guid_2/provider/charctaer_web_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:expandable_text/expandable_text.dart';

class AnimeDetailsPage extends ConsumerStatefulWidget {
  final Data animeList;

  const AnimeDetailsPage({super.key, required this.animeList});

  @override
  ConsumerState<AnimeDetailsPage> createState() => _AnimeDetailsPageState();
}

class _AnimeDetailsPageState extends ConsumerState<AnimeDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ref.watch(animeCharactersWebServicesProvider.notifier).willPopScope();
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              stackHeader(),
              cardDescription(),
              widget.animeList.trailer?.images?.largeImageUrl != null
                  ? youTubePlayerButton()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 190,
                        width: double.infinity,
                        child: Card(
                          clipBehavior: Clip.hardEdge,
                          child: Image.network(
                            'https://i.ytimg.com/vi/z8wrRRR7_qU/maxresdefault.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
              // youTubePlayerScreen(animeList: widget.animeList),
              Padding(
                padding: const EdgeInsets.only(bottom: 16, left: 16, top: 16),
                child:
                    AnimeCharactersPage(animeId: widget.animeList.malId ?? 0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget youTubePlayerButton() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return youTubePlayerScreen(
                animeList: widget.animeList,
              );
            }),
          );
        },
        child: Card(
          clipBehavior: Clip.hardEdge,
          child: SizedBox(
              height: 190,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    widget.animeList.trailer?.images?.largeImageUrl ?? '',
                    fit: BoxFit.cover,
                  ),
                  Center(
                    child: Image.asset(
                      'assets/images/youtube.png',
                      fit: BoxFit.cover,
                      height: 70,
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget stackHeader() {
    final amimeImage = widget.animeList.images.values.first.largeImageUrl;
    final title = widget.animeList.title;
    final titleJ = widget.animeList.titleJapanese;
    final type = widget.animeList.type;
    final episodes = widget.animeList.episodes;
    final status = widget.animeList.status;
    final day = widget.animeList.aired?.from?.day;
    final month = widget.animeList.aired?.from?.month;
    final year = widget.animeList.aired?.from?.year;

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      clipBehavior: Clip.hardEdge,
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 2.5,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(amimeImage ?? ''),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.7),
                    BlendMode.darken,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.grey[400],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        titleJ ?? '',
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //image
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3.7,
                      width: MediaQuery.of(context).size.height / 6.0,
                      child: Hero(
                        tag: 'animeDetail${widget.animeList.malId}',
                        child: Image.network(
                          amimeImage ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 40),
                          TextEdit(title: title),
                          Text(
                            '\nType: ${type ?? ''} | Episodes: ${episodes ?? ''}\nStatus: ${status ?? ''}\nAired : ${year ?? ''}-${month ?? ''}-${day ?? ''}',
                            // maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget cardDescription() {
    final synopsis = widget.animeList.synopsis; //
    final duration = widget.animeList.duration; //
    final score = widget.animeList.score; //
    final favorites = widget.animeList.favorites; //
    final season = widget.animeList.season; //
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Card(
            elevation: 3,
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child:
                            Image.asset('assets/images/star.png', height: 35),
                      ),
                      Text(score.toString()),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Image.asset('assets/images/favorite.png',
                            height: 35),
                      ),
                      Text(favorites.toString()),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Image.asset('assets/images/duration.png',
                            height: 35),
                      ),
                      Text(duration.toString()),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: season == 'spring'
                              ? Image.asset('assets/images/spring.png',
                                  height: 35)
                              : season == 'fall'
                                  ? Image.asset('assets/images/autumn.png',
                                      height: 35)
                                  : season == 'summer'
                                      ? Image.asset('assets/images/summer.png',
                                          height: 35)
                                      : Image.asset('assets/images/winter.png',
                                          height: 35)),
                      Text(season.toString()),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpandableText(
                synopsis ?? '',
                expandOnTextTap: true,
                collapseOnTextTap: true,
                expandText: '',
                linkColor: Colors.blue,
                maxLines: 5,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  // color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextEdit extends StatelessWidget {
  const TextEdit({
    super.key,
    required this.title,
  });

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? '',
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      softWrap: true,
      textAlign: TextAlign.start,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    );
  }
}
