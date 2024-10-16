import 'package:accurate/app_provider/app_provider.dart';
import 'package:accurate/constants/asset_images.dart';
import 'package:accurate/constants/routes.dart';
import 'package:accurate/models/product_model/product_model.dart';
import 'package:accurate/screens/product_details/product_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class SearchProduct extends StatelessWidget {
  const SearchProduct({
    super.key,
    required this.searchList,
  });

  final List<ProductModel> searchList;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: searchList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 0.0,
              crossAxisSpacing: 2.0,
              childAspectRatio: 3.5,
              crossAxisCount: 1,
            ),
            itemBuilder: (ctx, index) {
              ProductModel singleProduct = searchList[index];
              return Column(
                children: [
                  Card(
                    elevation: 10,
                    child: Container(
                      height: 105,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Routes.instance.push(
                                    widget: ProductDetails(
                                        singleProduct: singleProduct),
                                    context: context);
                              },
                              child: CachedNetworkImage(
                                imageUrl: singleProduct.image,
                                height: 140,
                                width: 140,
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    height: 140,
                                    width: 140,
                                    color: Colors.grey,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                //fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              height: 140,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: AppClr.whiteColor,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                singleProduct.name,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    height: 30,
                                                    width: 100,
                                                    child: OutlinedButton(
                                                      onPressed: () {
                                                        Routes.instance.push(
                                                          widget: ProductDetails(
                                                              singleProduct:
                                                                  singleProduct),
                                                          context: context,
                                                        );
                                                      },
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                        foregroundColor:
                                                            AppClr.whiteColor,
                                                        backgroundColor:
                                                            AppClr.primaryColor,
                                                        side: const BorderSide(
                                                            color: AppClr
                                                                .primaryColor,
                                                            width: 1.4),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      child: const Text(
                                                        'Buy',
                                                        style: TextStyle(
                                                          color:
                                                              AppClr.whiteColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "${singleProduct.price}/-",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          appProvider.toggleFavouriteStatus(
                                              singleProduct);
                                        },
                                        icon: Icon(
                                          appProvider.getFavouriteProductList
                                                  .contains(singleProduct)
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: AppClr.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
