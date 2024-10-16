import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ImageCard extends StatefulWidget {
  final String url;
  const ImageCard({super.key, required this.url});

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard>
    with SingleTickerProviderStateMixin {
  static final customCacheManager = CacheManager(
    Config('customCacheKey',
        stalePeriod: const Duration(days: 15), maxNrOfCacheObjects: 1000),
  );

  late TransformationController controller;
  late AnimationController animationController;
  Animation<Matrix4>? animation;
  @override
  void initState() {
    super.initState();

    controller = TransformationController();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() => controller.value = animation!.value);
  }

  final double minScale = 1;
  final double maxScale = 4;
  void resetAnimation() {
    animation = Matrix4Tween(
      begin: controller.value,
      end: Matrix4.identity(),
    ).animate(
        CurvedAnimation(parent: animationController, curve: Curves.bounceIn));
    animationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        height: 260,
        width: 390,
        // decoration: BoxDecoration(
        //     color: Colors.white,
        //     boxShadow: [
        //       BoxShadow(
        //         color: Color.fromARGB(188, 13, 72, 161),
        //         spreadRadius: 0.5,
        //         blurRadius: 2,
        //         offset: Offset(2, 2),
        //       ),
        //     ],
        //     borderRadius: BorderRadius.circular(10),
        //     border: Border.all(color: Colors.black)),
        child: InteractiveViewer(
          transformationController: controller,
          clipBehavior: Clip.none,
          panEnabled: false,
          minScale: minScale,
          maxScale: maxScale,
          onInteractionEnd: (details) {
            resetAnimation();
          },
          child: AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(9),
                  topRight: Radius.circular(9),
                  bottomLeft: Radius.circular(9),
                  bottomRight: Radius.circular(9)),
              child: CachedNetworkImage(
                imageUrl: widget.url,
                placeholder: (context, url) => const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 95, horizontal: 150),
                  child: CircularProgressIndicator(),
                ),
                cacheManager: customCacheManager,
                key: UniqueKey(),
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => const Center(child: Text("Network Issue")),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
