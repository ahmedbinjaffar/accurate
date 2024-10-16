// ignore_for_file: file_names

import 'package:accurate/constants/asset_images.dart';
import 'package:accurate/widgets/custom_shapes/containers/circular_container.dart';
import 'package:accurate/widgets/text/top_heading.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key, required this.videoID, required this.text});
  final String videoID;
  final String text;

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: widget.videoID,
    flags: const YoutubePlayerFlags(
        autoPlay: false,
        forceHD: false,
        showLiveFullscreenButton: false,
        disableDragSeek: false),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppClr.gradientcolor1.withOpacity(0.4),
                    AppClr.gradientcolor2.withOpacity(0.4),
                    AppClr.gradientcolor3.withOpacity(0.4)
                  ]),
            ),
            child: Stack(children: [
              Positioned(
                top: -150,
                right: -250,
                child: circularContainer(
                  backgroundcolor:
                      const Color.fromARGB(255, 103, 184, 250).withOpacity(0.2),
                ),
              ),
              Positioned(
                top: 100,
                right: -300,
                child: circularContainer(
                  backgroundcolor:
                      const Color.fromARGB(255, 103, 184, 250).withOpacity(0.2),
                ),
              ),
              Column(children: [
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const BackButton(
                        color: AppClr.primaryColor,
                      ),
                      Expanded(
                        child: TopHeading(
                          title: widget.text,
                          colour: AppClr.primaryColor,
                        ),
                      ),
                      CircleAvatar(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              AssetsImages.instance.logoimage,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  bottomActions: [
                    CurrentPosition(),
                    ProgressBar(
                      isExpanded: true,
                      colors: const ProgressBarColors(
                          playedColor: AppClr.primaryColor,
                          handleColor: AppClr.primaryColor),
                    ),
                    const PlaybackSpeedButton(),
                  ],
                ),
              ]),
            ])));
  }
}
