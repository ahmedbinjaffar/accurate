import 'package:accurate/app_provider/app_provider.dart';
import 'package:accurate/constants/asset_images.dart';
import 'package:accurate/screens/favourite_screen/widgets/single_favourite_item.dart';
import 'package:accurate/widgets/custom_shapes/containers/circular_container.dart';
import 'package:accurate/widgets/text/top_heading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  final bool showBackButton;

  const FavouriteScreen({super.key, required this.showBackButton});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
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
                  const SizedBox(height: 40),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          widget.showBackButton
                              ? const BackButton(
                                  color: AppClr.primaryColor,
                                )
                              : Container(
                                  width: 48.0, // Same width as BackButton
                                ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TopHeading(
                              title: "Favourite Products",
                              colour: AppClr.primaryColor,
                            ),
                          ),
                          Container(
                            width: 48.0, // Same width as BackButton
                          ),
                        ]),
                  ),
                ]),
                appProvider.getFavouriteProductList.isEmpty
                    ? const Center(
                        child: Text("Empty"),
                      )
                    : Column(
                        children: [
                          const SizedBox(
                            height: 90,
                          ),
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount:
                                  appProvider.getFavouriteProductList.length,
                              padding: const EdgeInsets.all(30),
                              itemBuilder: (ctx, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: SingleFavouriteItem(
                                    singleProduct: appProvider
                                        .getFavouriteProductList[index],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )
              ],
            )));
  }
}
