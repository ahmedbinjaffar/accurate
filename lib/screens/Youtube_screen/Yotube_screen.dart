// ignore_for_file: file_names

import 'package:accurate/constants/asset_images.dart';
import 'package:accurate/constants/routes.dart';
import 'package:accurate/firebase_helper/firebase_firestore/firebase_firestore.dart';
import 'package:accurate/models/youtube_model/youtube_model.dart';
import 'package:accurate/screens/Youtube_screen/widget/Player_screen.dart';
import 'package:accurate/widgets/custom_shapes/containers/circular_container.dart';
import 'package:accurate/widgets/text/top_heading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeScreen extends StatefulWidget {
  const YoutubeScreen({super.key});

  @override
  State<YoutubeScreen> createState() => _YoutubeScreenState();
}

class _YoutubeScreenState extends State<YoutubeScreen> {
  List<YoutubeModel> youtubeModelList = [];
  List<YoutubeModel> filteredList = [];
  bool isLoading = false;

  TextEditingController searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    getYoutubeList();
  }

  void getYoutubeList() async {
    setState(() {
      isLoading = true;
    });
    youtubeModelList =
        await FirebaseFirestoreHelper.instance.getYouTubeVideos();
    filteredList = youtubeModelList;
    setState(() {
      isLoading = false;
    });
  }

  void searchFun(String value) {
    setState(() {
      filteredList = youtubeModelList
          .where((youtubeVideo) =>
              youtubeVideo.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

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
              AppClr.gradientcolor3.withOpacity(0.4),
            ],
          ),
        ),
        child: Stack(
          children: [
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
            Column(
              children: [
                const SizedBox(height: 50),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TopHeading(
                        title: "YouTube Videos",
                        colour: AppClr.primaryColor,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    controller: searchCtrl,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppClr.whiteColor,
                      hintText: 'Search YouTube Videos',
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: AppClr.gradientcolor3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      searchFun(value);
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: filteredList.length,
                    itemBuilder: (ctx, index) {
                      final YoutubeModel singleYoutube = filteredList[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: InkWell(
                          onTap: () {
                            Routes.instance.push(
                              widget: PlayerScreen(
                                videoID: singleYoutube.url,
                                text: singleYoutube.name,
                              ),
                              context: context,
                            );
                          },
                          child: Card(
                            elevation: 10, // Removed shadow
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: EdgeInsets.zero, // Removed margin
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: CachedNetworkImage(
                                height: 246,
                                width: double.infinity,
                                imageUrl: YoutubePlayer.getThumbnail(
                                  videoId: singleYoutube.url,
                                ),
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
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
