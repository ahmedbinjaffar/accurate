// import 'package:accurate/app_provider/app_provider.dart';
// import 'package:accurate/constants/colors.dart';
// import 'package:accurate/constants/constants.dart';
// import 'package:accurate/models/product_model/product_model.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class Single_cart_item extends StatefulWidget {
//   final ProductModel singleProduct;
//   const Single_cart_item({super.key, required this.singleProduct});

//   @override
//   State<Single_cart_item> createState() => _Single_cart_itemState();
// }

// class _Single_cart_itemState extends State<Single_cart_item> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 12),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: AppClr.primaryColor, width: 2.3)),
//       child: Row(
//         children: [
//           Expanded(
//             child: Container(
//               height: 140,
//               color: AppClr.primaryColor.withOpacity(0.25),
//               child: Image.network(
//                 widget.singleProduct.image,
//                 height: 140,
//                 width: 140,
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: SizedBox(
//               height: 140,
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Stack(
//                   alignment: Alignment.bottomRight,
//                   children: [
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               widget.singleProduct.name,
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 18,
//                               ),
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Row(
//                               children: [
//                                 CupertinoButton(
//                                   padding: EdgeInsets.zero,
//                                   onPressed: () {},
//                                   child: Text(
//                                     "Add to Wishlist",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 13,
//                                         color: AppClr.primaryColor),
//                                   ),
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                         Text(
//                           "\$${widget.singleProduct.price.toString()}",
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18,
//                           ),
//                         )
//                       ],
//                     ),
//                     CupertinoButton(
//                         padding: EdgeInsets.zero,
//                         onPressed: () {
//                           AppProvider appProvider =
//                               Provider.of<AppProvider>(context, listen: false);
//                           appProvider.removeCartProduct(widget.singleProduct);
//                           showMessage('Removed from Cart');
//                         },
//                         child: CircleAvatar(
//                             backgroundColor: AppClr.primaryColor,
//                             maxRadius: 13,
//                             child: Icon(
//                               Icons.delete,
//                               size: 17,
//                               color: AppClr.whiteColor,
//                             ))),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
