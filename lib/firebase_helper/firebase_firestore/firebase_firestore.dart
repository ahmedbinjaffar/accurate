import 'dart:developer';

import 'package:accurate/constants/constants.dart';
import 'package:accurate/models/banner_model/banner_model.dart';
import 'package:accurate/models/calendar_model/calendar_model.dart';
import 'package:accurate/models/category_model/category_model.dart';
import 'package:accurate/models/product_model/product_model.dart';
import 'package:accurate/models/youtube_model/youtube_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreHelper {
  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getCategories() async {
    log("getCategories");
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection("categories")
              .orderBy(
                'timestamp',
              ) // Order by timestamp, descending
              .get();

      List<CategoryModel> categoriesList = querySnapshot.docs
          .map((e) => CategoryModel.fromJson(e.data(), e.id))
          .toList();
      log("Length : ${categoriesList.length}");
      return categoriesList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getbestProducts() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collectionGroup("products").get();

      List<ProductModel> productModelList = querySnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();
      return productModelList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getCategoryViewProduct(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection("categories")
              .doc(id)
              .collection("products")
              .orderBy('timestamp',
                  descending: true) // Order by timestamp, descending
              .get();

      List<ProductModel> productModelList = querySnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();

      return productModelList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<List<YoutubeModel>> getYouTubeVideos() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("youtube").get();

      List<YoutubeModel> youtubeList = querySnapshot.docs
          .map((e) => YoutubeModel.fromJson(e.data()))
          .toList();
      return youtubeList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<List<CalendarModel>> getCalendar() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection("calendar")
              .orderBy(
                'timestamp',
              ) // Order by timestamp, descending
              .get();

      List<CalendarModel> calendarList = querySnapshot.docs
          .map((e) => CalendarModel.fromJson(e.data()))
          .toList();

      return calendarList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<List<BannerModel>> getsingleBanner() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection("banner").get();

      List<BannerModel> bannerList = querySnapshot.docs
          .map((e) => BannerModel.fromJson(e.data()))
          .toList();
      return bannerList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }
}
