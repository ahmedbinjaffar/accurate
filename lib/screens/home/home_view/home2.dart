import 'dart:async';
import 'package:accurate/app_provider/app_provider.dart';
import 'package:accurate/screens/home/home_view/widgets/shimmer_loading/shimmer_loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:accurate/constants/asset_images.dart';
import 'package:accurate/constants/routes.dart';
import 'package:accurate/screens/category_view/category_view.dart';
import 'package:accurate/screens/home/home_view/widgets/banner_card/banner_card.dart';
import 'package:accurate/screens/home/home_view/widgets/best_products.dart';
import 'package:accurate/screens/home/home_view/widgets/search_products.dart';
import 'package:accurate/widgets/text/top_heading.dart';
import 'package:accurate/firebase_helper/firebase_firestore/firebase_firestore.dart';
import 'package:accurate/models/banner_model/banner_model.dart';
import 'package:accurate/models/category_model/category_model.dart';
import 'package:accurate/models/product_model/product_model.dart';
import 'package:accurate/widgets/custom_shapes/containers/circular_container.dart';
import 'package:accurate/widgets/custom_shapes/curved_edges/curved_edges.dart';
import 'package:accurate/widgets/text/section_heading.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home2 extends StatefulWidget {
  const Home2({super.key});

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  List<CategoryModel>? _categoriesCache;
  List<ProductModel>? _productsCache;

  TextEditingController search = TextEditingController();
  List<ProductModel> searchList = [];

  double xOffset = 0;
  double yOffset = 0;
  bool _showShimmer = true;
  bool isDrawerOpen = false;
  late PageController mycontroller;
  late PageController indicatorController;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    mycontroller = PageController(viewportFraction: 0.9, initialPage: 2);
    indicatorController = PageController();
    // Preload categories and products
    _preloadData();
  }

  Future<void> _preloadData() async {
    try {
      final results = await Future.wait([
        FirebaseFirestoreHelper.instance.getCategories(),
        FirebaseFirestoreHelper.instance.getbestProducts()
      ]);

      _categoriesCache = results[0] as List<CategoryModel>;
      _productsCache = results[1] as List<ProductModel>;

      // Shuffle products if needed
      _productsCache!.shuffle();

      // Trigger rebuild to display preloaded data
      setState(() {
        _showShimmer = false;
      });

      // Initialize banner cycling function
      final bannerModelList =
          // ignore: use_build_context_synchronously
          Provider.of<AppProvider>(context, listen: false).getBanner;
      if (bannerModelList.isNotEmpty) {
        // Delay the initialization of the timer to ensure the PageView is ready
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _startBannerTimer(bannerModelList);
        });
      }
    } catch (e) {
      // Handle any errors that occur during data fetching
    }
  }

  void searchProducts(String value) {
    if (_productsCache != null) {
      searchList = _productsCache!
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
      setState(() {});
    }
  }

  void _startBannerTimer(List<BannerModel> bannerModelList) {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (bannerModelList.isEmpty) return;

      if (indicatorController.hasClients) {
        setState(() {
          final currentIndex = (indicatorController.page ?? 0).toInt();
          final nextIndex = (currentIndex + 1) % bannerModelList.length;
          indicatorController.animateToPage(
            nextIndex,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    mycontroller.dispose();
    indicatorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bannerModelList = Provider.of<AppProvider>(context).getBanner;

    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx > 0) {
          // Swiping right to open the drawer
          if (!isDrawerOpen) {
            setState(() {
              xOffset = 360;
              yOffset = 90;
              isDrawerOpen = true;
            });
          }
        } else if (details.delta.dx < 0) {
          // Swiping left to close the drawer
          if (isDrawerOpen) {
            setState(() {
              xOffset = 0;
              yOffset = 0;
              isDrawerOpen = false;
            });
          }
        }
      },
      child: AnimatedContainer(
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
          ..scale(isDrawerOpen ? 0.85 : 1.00)
          ..rotateZ(isDrawerOpen ? -50 : 0),
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              isDrawerOpen ? BorderRadius.circular(40) : BorderRadius.zero,
        ),
        child: Scaffold(
          body:
              _showShimmer || _categoriesCache == null || _productsCache == null
                  ? const Center(
                      child: ShimmerPage(),
                    )
                  : Column(
                      children: [
                        ClipPath(
                          clipper: CustomCurvedEdgets(),
                          child: Container(
                            color: AppClr.primaryColor,
                            child: SizedBox(
                              height: 370,
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: -150,
                                    right: -250,
                                    child: circularContainer(
                                      backgroundcolor:
                                          Colors.blue.withOpacity(0.2),
                                    ),
                                  ),
                                  Positioned(
                                    top: 100,
                                    right: -300,
                                    child: circularContainer(
                                      backgroundcolor:
                                          Colors.blue.withOpacity(0.2),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      const SizedBox(height: 50),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  xOffset =
                                                      isDrawerOpen ? 0 : 360;
                                                  yOffset =
                                                      isDrawerOpen ? 0 : 90;
                                                  isDrawerOpen = !isDrawerOpen;
                                                });
                                              },
                                              child: Icon(
                                                isDrawerOpen
                                                    ? Icons.arrow_back
                                                    : Icons.menu,
                                                color: AppClr.whiteColor,
                                              ),
                                            ),
                                            const TopHeading(
                                              title: "Accurate Scale",
                                              colour: AppClr.whiteColor,
                                            ),
                                            Container(),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: SizedBox(
                                          height: 60,
                                          child: TextFormField(
                                            controller: search,
                                            onChanged: (String value) {
                                              searchProducts(value);
                                            },
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: AppClr.whiteColor,
                                              hintText:
                                                  'Search Only Product Items',
                                              prefixIcon:
                                                  const Icon(Icons.search),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: AppClr.whiteColor),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 5),
                                        child: SectionHeading(
                                          title: 'Popular Categories',
                                          showActionButton: false,
                                          textcolor: AppClr.whiteColor,
                                        ),
                                      ),
                                      _categoriesCache == null
                                          ? const Center(
                                              child: Text(
                                                "Loading Categories...",
                                                style: TextStyle(
                                                    color: AppClr.whiteColor),
                                              ),
                                            )
                                          : SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children:
                                                    _categoriesCache!.map((e) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: CupertinoButton(
                                                      padding: EdgeInsets.zero,
                                                      onPressed: () {
                                                        Routes.instance.push(
                                                            widget: CategoryView(
                                                                categoryModel:
                                                                    e),
                                                            context: context);
                                                      },
                                                      child: Column(
                                                        children: [
                                                          Card(
                                                            elevation: 5,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100),
                                                            ),
                                                            child: SizedBox(
                                                              height: 70,
                                                              width: 70,
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  SizedBox(
                                                                    height: 60,
                                                                    width: 60,
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              100),
                                                                      child:
                                                                          CachedNetworkImage(
                                                                        imageUrl:
                                                                            e.image,
                                                                        placeholder:
                                                                            (context, url) =>
                                                                                Shimmer.fromColors(
                                                                          baseColor:
                                                                              Colors.grey[300]!,
                                                                          highlightColor:
                                                                              Colors.grey[100]!,
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                60,
                                                                            width:
                                                                                60,
                                                                            color:
                                                                                Colors.grey,
                                                                          ),
                                                                        ),
                                                                        errorWidget: (context,
                                                                                url,
                                                                                error) =>
                                                                            const Icon(Icons.error),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 9),
                                                          Text(
                                                            e.name,
                                                            style: const TextStyle(
                                                                color: AppClr
                                                                    .whiteColor,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 250,
                          child: Stack(
                            children: [
                              PageView.builder(
                                controller: mycontroller,
                                itemCount: bannerModelList.length,
                                itemBuilder: (context, index) {
                                  final BannerModel singlebanner =
                                      bannerModelList[index];
                                  return BannerCard(
                                    singleBanner: singlebanner,
                                  );
                                },
                                onPageChanged: (index) {
                                  // Sync the indicator with the PageView
                                  if (indicatorController.hasClients) {
                                    indicatorController.animateToPage(index,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut);
                                  }
                                },
                              ),
                              Positioned(
                                bottom: 10,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: SmoothPageIndicator(
                                    controller: mycontroller,
                                    count: bannerModelList.length,
                                    effect: ExpandingDotsEffect(
                                      dotHeight: 10,
                                      dotWidth: 10,
                                      activeDotColor: AppClr.primaryColor,
                                      dotColor: Colors.grey.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        !isSearched()
                            ? const Padding(
                                padding: EdgeInsets.only(top: 12.0, left: 17.0),
                                child: Row(
                                  children: [
                                    SectionHeading(
                                        title: "Best Product",
                                        showActionButton: false),
                                  ],
                                ),
                              )
                            : SizedBox.fromSize(),
                        const SizedBox(height: 1.0),
                        _productsCache == null
                            ? const Center(
                                child: Text('Loading Products...'),
                              )
                            : search.text.isNotEmpty && searchList.isEmpty
                                ? const Center(child: Text('No Product Found'))
                                : searchList.isNotEmpty
                                    ? SearchProduct(searchList: searchList)
                                    : BestProducts(
                                        productModelList: _productsCache!),
                      ],
                    ),
        ),
      ),
    );
  }

  bool isSearched() {
    if (search.text.isNotEmpty && searchList.isEmpty) {
      return true;
    } else if (search.text.isEmpty && searchList.isNotEmpty) {
      return false;
    } else if (searchList.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
