import 'package:accurate/constants/colors.dart';
import 'package:accurate/models/product_model/product_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;

  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(isDrawerOpen ? 0.85 : 1.00)
        ..rotateZ(isDrawerOpen ? -50 : 0),
      duration: const Duration(microseconds: 200),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            isDrawerOpen ? BorderRadius.circular(40) : BorderRadius.circular(0),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  isDrawerOpen
                      ? GestureDetector(
                          child: const Icon(Icons.arrow_back_ios),
                          onTap: () {
                            setState(() {
                              xOffset = 0;
                              yOffset = 0;
                              isDrawerOpen = false;
                            });
                          },
                        )
                      : GestureDetector(
                          child: const Icon(Icons.menu),
                          onTap: () {
                            setState(() {
                              xOffset = 360;
                              yOffset = 90;
                              isDrawerOpen = true;
                            });
                          },
                        ),
                  const Text(
                    'Accurate Scale',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                        decoration: TextDecoration.none),
                  ),
                  Container(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: 60,
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Search Only Product Items',
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Row(
                children: [
                  Text(
                    "Categories",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categoriesList
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Card(
                          color: Colors.white70,
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.network(e),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 12.0, left: 17.0),
              child: Row(
                children: [
                  Text(
                    "Best Products",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: bestproducts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 20.0,
                      crossAxisSpacing: 20.0,
                      childAspectRatio: 0.9,
                      crossAxisCount: 2),
                  itemBuilder: (ctx, index) {
                    ProductModel singleProduct = bestproducts[index];
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        color: AppClr.primaryColor.withOpacity(0.3),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 12.0,
                            ),
                            Image.network(
                              singleProduct.image,
                              height: 80.0,
                              width: 80.0,
                            ),
                            SizedBox(height: 12.0),
                            Text(
                              singleProduct.name,
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            Text("Price: ${singleProduct.price}"),
                            SizedBox(height: 30.0),
                            SizedBox(
                                height: 45,
                                width: 140,
                                child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                          color: AppClr.primaryColor,
                                          width: 1.4,
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    onPressed: () {},
                                    child: Text(
                                      "Buy",
                                      style: TextStyle(
                                          color: AppClr.primaryColor,
                                          fontWeight: FontWeight.bold),
                                    ))),
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

List<String> categoriesList = [
  "https://accuratescaleplus.com/wp-content/uploads/2022/09/AE-8890W1-600x600.png",
  "https://accuratescaleplus.com/wp-content/uploads/2022/09/AE-91S-2.png",
  "https://accuratescaleplus.com/wp-content/uploads/2022/10/a.png",
  "https://accuratescaleplus.com/wp-content/uploads/2022/10/a.png"
];

List<ProductModel> bestproducts = [
  ProductModel(
      image: "https://accuratescaleplus.com/wp-content/uploads/2022/10/a.png",
      id: "1",
      name: "AE-9060ss",
      price: "1500/-",
      description: "This is good Product",
      status: "pending",
      isFavourite: false),
  ProductModel(
      image: "https://accuratescaleplus.com/wp-content/uploads/2022/10/a.png",
      id: "1",
      name: "AE-9060ss",
      price: "1500/-",
      description: "This is good Product",
      status: "pending",
      isFavourite: false),
  ProductModel(
      image: "https://accuratescaleplus.com/wp-content/uploads/2022/10/a.png",
      id: "1",
      name: "AE-9060ss",
      price: "1500/-",
      description: "This is good Product",
      status: "pending",
      isFavourite: false),
  ProductModel(
      image: "https://accuratescaleplus.com/wp-content/uploads/2022/10/a.png",
      id: "1",
      name: "AE-9060ss",
      price: "1500/-",
      description: "This is good Product",
      status: "pending",
      isFavourite: false),
  ProductModel(
      image: "https://accuratescaleplus.com/wp-content/uploads/2022/10/a.png",
      id: "1",
      name: "AE-9060ss",
      price: "1500/-",
      description: "This is good Product",
      status: "pending",
      isFavourite: false),
  ProductModel(
      image: "https://accuratescaleplus.com/wp-content/uploads/2022/10/a.png",
      id: "1",
      name: "AE-9060ss",
      price: "1500/-",
      description: "This is good Product",
      status: "pending",
      isFavourite: false),
  ProductModel(
      image: "https://accuratescaleplus.com/wp-content/uploads/2022/10/a.png",
      id: "1",
      name: "AE-9060ss",
      price: "1500/-",
      description: "This is good Product",
      status: "pending",
      isFavourite: false),
  ProductModel(
      image: "https://accuratescaleplus.com/wp-content/uploads/2022/10/a.png",
      id: "1",
      name: "AE-9060ss",
      price: "1500/-",
      description: "This is good Product",
      status: "pending",
      isFavourite: false),
  ProductModel(
      image: "https://accuratescaleplus.com/wp-content/uploads/2022/10/a.png",
      id: "1",
      name: "AE-9060ss",
      price: "1500/-",
      description: "This is good Product",
      status: "pending",
      isFavourite: false),
];
