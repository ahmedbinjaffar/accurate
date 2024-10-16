import 'package:accurate/constants/asset_images.dart';
import 'package:accurate/firebase_helper/firebase_firestore/firebase_firestore.dart';
import 'package:accurate/models/category_model/category_model.dart';
import 'package:accurate/models/product_model/product_model.dart';
import 'package:accurate/screens/product_details/product_details.dart';
import 'package:accurate/widgets/custom_shapes/containers/circular_container.dart';
import 'package:accurate/widgets/shimmer/shimmer.dart';
import 'package:accurate/widgets/text/top_heading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryView extends StatefulWidget {
  final CategoryModel categoryModel;
  const CategoryView({super.key, required this.categoryModel});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<ProductModel> productModelList = [];

  bool isLoading = false;

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });

    productModelList = await FirebaseFirestoreHelper.instance
        .getCategoryViewProduct(widget.categoryModel.id);
    //productModelList.shuffle();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: ShimmerLoading(),
            )
          : Stack(
              children: [
                Container(
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
                ),
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
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
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
                            TopHeading(
                              title: widget.categoryModel.name,
                              colour: AppClr.primaryColor,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      productModelList.isEmpty
                          ? const Center(
                              child: Text(
                                "Best Product is Empty",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            )
                          : GridView.builder(
                              padding: const EdgeInsets.all(20),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: productModelList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 25.0,
                                crossAxisSpacing: 25.0,
                                childAspectRatio: 0.8,
                                crossAxisCount: 2,
                              ),
                              itemBuilder: (ctx, index) {
                                ProductModel singleProduct =
                                    productModelList[index];
                                return CachedNetworkImage(
                                  imageUrl: singleProduct.image,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      color: AppClr.whiteColor,
                                      boxShadow: const [
                                        BoxShadow(
                                          color:
                                              Color.fromARGB(188, 13, 72, 161),
                                          spreadRadius: 0.5,
                                          blurRadius: 2,
                                          offset: Offset(2, 2),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                          color: AppClr.primaryColor),
                                    ),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 5.0),
                                        Image(
                                          image: imageProvider,
                                          height: 100,
                                          width: 100,
                                        ),
                                        const SizedBox(height: 12.0),
                                        Text(
                                          singleProduct.name,
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text("Price: ${singleProduct.price}"),
                                        const SizedBox(height: 30.0),
                                        SizedBox(
                                          height: 45,
                                          width: 140,
                                          child: OutlinedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductDetails(
                                                    singleProduct:
                                                        singleProduct,
                                                  ),
                                                ),
                                              );
                                            },
                                            style: OutlinedButton.styleFrom(
                                              foregroundColor:
                                                  AppClr.whiteColor,
                                              backgroundColor:
                                                  AppClr.primaryColor,
                                              side: const BorderSide(
                                                color: AppClr.primaryColor,
                                                width: 1.4,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            child: const Text(
                                              "Buy",
                                              style: TextStyle(
                                                color: AppClr.whiteColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      width: double.infinity,
                                      height: 300, // Adjust height as needed
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                );
                              },
                            ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
