// ignore_for_file: deprecated_member_use

import 'package:accurate/constants/asset_images.dart';
import 'package:accurate/models/Drawer_model/social_media_model/social_media_model.dart';
import 'package:accurate/widgets/custom_shapes/containers/circular_container.dart';
import 'package:accurate/widgets/text/top_heading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia({super.key});

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
                          const TopHeading(
                            title: "Social Media",
                            colour: AppClr.primaryColor,
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
                        ]),
                  ),
                ]),
                Column(
                  children: [
                    const SizedBox(
                      height: 90,
                    ),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: shop_models.length,
                        padding: const EdgeInsets.all(30),
                        itemBuilder: (ctx, index) {
                          return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                children: [
                                  CupertinoButton(
                                    onPressed: () async {
                                      final url = shop_models[index].linkii;
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      }
                                    },
                                    child: Image.asset(
                                      shop_models[index].socialmediaicon,
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                  Text(shop_models[index].socialname)
                                ],
                              ));
                        },
                      ),
                    ),
                  ],
                )
              ],
            )));
  }
}
