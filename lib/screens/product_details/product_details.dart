import 'package:accurate/app_provider/app_provider.dart';
import 'package:accurate/constants/asset_images.dart';
import 'package:accurate/models/product_model/product_model.dart';
import 'package:accurate/widgets/custom_shapes/containers/circular_container.dart';
import 'package:accurate/widgets/custom_shapes/curved_edges/curved_edges.dart';
import 'package:accurate/widgets/text/top_heading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel singleProduct;
  const ProductDetails({super.key, required this.singleProduct});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
        body: Column(children: [
      ClipPath(
        clipper: CustomCurvedEdgets(),
        child: Container(
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
          child: SizedBox(
            height: 620,
            child: Stack(
              children: [
                Positioned(
                  top: -150,
                  right: -250,
                  child: circularContainer(
                    backgroundcolor: const Color.fromARGB(255, 103, 184, 250)
                        .withOpacity(0.2),
                  ),
                ),
                Positioned(
                  top: 100,
                  right: -300,
                  child: circularContainer(
                    backgroundcolor: const Color.fromARGB(255, 103, 184, 250)
                        .withOpacity(0.2),
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(height: 50),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const BackButton(
                            color: AppClr.primaryColor,
                          ),
                          const TopHeading(
                            title: "Product Details",
                            colour: AppClr.primaryColor,
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  widget.singleProduct.isFavourite =
                                      !widget.singleProduct.isFavourite;
                                });
                                if (widget.singleProduct.isFavourite) {
                                  appProvider.addFavouriteProduct(
                                      widget.singleProduct);
                                } else {
                                  appProvider.removeFavouriteProduct(
                                      widget.singleProduct);
                                }
                              },
                              icon: Icon(
                                appProvider.getFavouriteProductList
                                        .contains(widget.singleProduct)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: AppClr.primaryColor,
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Column(children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.414,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(188, 13, 72, 161),
                                  spreadRadius: 0.5,
                                  blurRadius: 2,
                                  offset: Offset(2, 2),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppClr.primaryColor),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: CachedNetworkImage(
                                      imageUrl: widget.singleProduct.image,
                                      width: 350,
                                      height: 350,
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: Container(
                                          width: 350,
                                          height: 350,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(7),
                                        bottomRight: Radius.circular(7),
                                      ),
                                      color: AppClr.primaryColor,
                                    ),
                                    child: Center(
                                      child: Text(
                                        widget.singleProduct.name,
                                        style: const TextStyle(
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold,
                                          color: AppClr.whiteColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))
                    ])
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      Expanded(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Specification",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.singleProduct.description,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.08,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppClr.gradientcolor1,
                    AppClr.gradientcolor2,
                    AppClr.gradientcolor3
                  ]),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(188, 13, 72, 161),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(1, 1),
                ),
              ],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(9), topRight: Radius.circular(9)),
              color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Price: ${widget.singleProduct.price}",
                  style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 5, 44, 102))),
              SizedBox(
                height: 44,
                width: 140,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppClr.primaryColor,
                    elevation: 5,
                    shadowColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  onPressed: () async {
                    final url = widget.singleProduct.url;

                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(Uri.parse(url));
                    }
                  },
                  child: const Text(
                    "Buy Now",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    ]));
  }
}
