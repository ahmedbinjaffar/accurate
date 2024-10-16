// import 'package:accurate/app_provider/app_provider.dart';
// import 'package:accurate/constants/colors.dart';
// import 'package:accurate/screens/cart_screen/widgets/single_screen.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class CartScreen extends StatelessWidget {
//   const CartScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     AppProvider appProvider = Provider.of<AppProvider>(context);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppClr.whiteColor,
//         title: Text(
//           'Cart Screen',
//         ),
//       ),
//       body: appProvider.getCartProductList.isEmpty
//           ? Center(
//               child: Text("Empty"),
//             )
//           : ListView.builder(
//               itemCount: appProvider.getCartProductList.length,
//               padding: EdgeInsets.all(12),
//               itemBuilder: (ctx, index) {
//                 return Single_cart_item(
//                   singleProduct: appProvider.getCartProductList[index],
//                 );
//               },
//             ),
//     );
//   }
// }
