// ignore_for_file: file_names, camel_case_types

import 'package:anime_guid_2/models/anime_json.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class youTubePlayerScreen extends StatefulWidget {
  const youTubePlayerScreen({
    super.key,
    required this.animeList,
  });

  final Data animeList;

  @override
  State<youTubePlayerScreen> createState() => _youTubePlayerScreenState();
}

class _youTubePlayerScreenState extends State<youTubePlayerScreen> {
  late final YoutubePlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.animeList.trailer?.youtubeId ?? '',
      flags: const YoutubePlayerFlags(
        forceHD: true,
        showLiveFullscreenButton: false,
        autoPlay: false,

        // mute: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.95),
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.92),
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.cancel_outlined,
              color: Colors.white,
            )),
      ),
      body: Center(
        child: Card(
          child: YoutubePlayer(
            bottomActions: [
              CurrentPosition(),
              ProgressBar(
                isExpanded: true,
                colors: const ProgressBarColors(
                  handleColor: Colors.red,
                  playedColor: Colors.red,
                ),
              ),
              RemainingDuration(),
              // PlayPauseButton(),
              const PlaybackSpeedButton(),

              // FullScreenButton(),
            ],
            controller: _controller,
            //   showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.blueAccent,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
