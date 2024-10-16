// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:accurate/models/banner_model/banner_model.dart';
import 'package:accurate/models/calendar_model/calendar_model.dart';
import 'package:accurate/models/category_model/category_model.dart';
import 'package:accurate/models/product_model/product_model.dart';
import 'package:accurate/models/youtube_model/youtube_model.dart';
import 'package:accurate/firebase_helper/firebase_firestore/firebase_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';

class AppProvider with ChangeNotifier {
  final List<ProductModel> _cartProductList = [];
  List<CategoryModel> _categoryList = [];
  List<ProductModel> _productsList = [];
  List<YoutubeModel> _youtubeList = [];
  List<CalendarModel> _calendarList = [];
  List<BannerModel> _bannerList = [];
  List<ProductModel> _favouriteProductList = [];

  AppProvider() {
    // Initialize data
    loadFavouriteProducts();
    getCategoriesListFun();
    getBanners();
  }

  // Categories Methods
  Future<void> getCategoriesListFun() async {
    try {
      _categoryList = await FirebaseFirestoreHelper.instance.getCategories();
      notifyListeners();
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  List<CategoryModel> get getCategoriesList => _categoryList;

  // Product Methods
  Future<void> getProduct() async {
    try {
      _productsList = await FirebaseFirestoreHelper.instance.getbestProducts();
      notifyListeners();
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  List<ProductModel> get getProducts => _productsList;

  void addCartProduct(ProductModel productModel) {
    _cartProductList.add(productModel);
    notifyListeners();
  }

  void removeCartProduct(ProductModel productModel) {
    _cartProductList.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getCartProductList => _cartProductList;

  // Favourite List
  void addFavouriteProduct(ProductModel productModel) {
    if (!_favouriteProductList.contains(productModel)) {
      _favouriteProductList.add(productModel);
      saveFavouriteProducts(); // Save to SharedPreferences
      notifyListeners();
    }
  }

  void removeFavouriteProduct(ProductModel productModel) {
    if (_favouriteProductList.contains(productModel)) {
      _favouriteProductList.remove(productModel);
      saveFavouriteProducts(); // Save to SharedPreferences
      notifyListeners();
    }
  }

  Future<void> saveFavouriteProducts() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> productStrings = _favouriteProductList
          .map((product) => jsonEncode(product.toJson()))
          .toList();
      print('Saving products: $productStrings'); // Debug print
      await prefs.setStringList('favouriteProducts', productStrings);
      print('Products saved successfully');
    } catch (e) {
      print('Error saving products: $e');
    }
  }

  Future<void> loadFavouriteProducts() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? productStrings = prefs.getStringList('favouriteProducts');
      print('Loaded products: $productStrings'); // Debug print
      if (productStrings != null) {
        _favouriteProductList = productStrings
            .map((productString) {
              try {
                return ProductModel.fromJson(jsonDecode(productString));
              } catch (e) {
                print('Error decoding product: $e'); // Debug print
                return null;
              }
            })
            .where((product) => product != null)
            .cast<ProductModel>()
            .toList();
      } else {
        _favouriteProductList = [];
      }
      notifyListeners();
    } catch (e) {
      print('Error loading products: $e');
    }
  }

  void toggleFavouriteStatus(ProductModel productModel) {
    if (_favouriteProductList.contains(productModel)) {
      removeFavouriteProduct(productModel);
    } else {
      addFavouriteProduct(productModel);
    }
  }

  bool isFavourite(ProductModel productModel) {
    return _favouriteProductList.contains(productModel);
  }

  List<ProductModel> get getFavouriteProductList => _favouriteProductList;

  // YouTube Methods
  Future<void> getYotubes() async {
    try {
      _youtubeList = await FirebaseFirestoreHelper.instance.getYouTubeVideos();
      notifyListeners();
    } catch (e) {
      print('Error fetching YouTube videos: $e');
    }
  }

  List<YoutubeModel> get getYoutube => _youtubeList;

  // Calendar Methods
  Future<void> getCa() async {
    try {
      _calendarList = await FirebaseFirestoreHelper.instance.getCalendar();
      notifyListeners();
    } catch (e) {
      print('Error fetching calendar events: $e');
    }
  }

  List<CalendarModel> get getCalendar => _calendarList;

  Future<void> getBanners() async {
    try {
      _bannerList = await FirebaseFirestoreHelper.instance.getsingleBanner();
      notifyListeners();
    } catch (e) {
      print('Error fetching banners: $e');
    }
  }

  List<BannerModel> get getBanner => _bannerList;

  final Gemini gemini = Gemini.instance;
  List<ChatMessage> messages = [];

  ChatUser currentUser = ChatUser(id: '0', firstName: 'Users');
  ChatUser geminiUser = ChatUser(
    id: '1',
    firstName: 'Accurate Scale',
    profileImage:
        'https://firebasestorage.googleapis.com/v0/b/accurate-scale-2024.appspot.com/o/logo.png?alt=media&token=04040a41-619f-49e2-adc2-6e2ca6700a2a',
  );

  final translator = GoogleTranslator(); // Initialize the translator

  void sendMessage(ChatMessage chatMessage) async {
    messages = [chatMessage, ...messages];
    notifyListeners();

    try {
      String question = chatMessage.text;

      // Translate to Urdu
      String urduQuestion = await translateToUrdu(question);

      gemini.streamGenerateContent(urduQuestion).listen((event) {
        ChatMessage? lastMessage = messages.firstOrNull;
        if (lastMessage != null && lastMessage.user == geminiUser) {
          lastMessage = messages.removeAt(0);
          String response = event.content?.parts?.fold(
                  '', (previous, current) => '$previous ${current.text}') ??
              '';
          lastMessage.text += response;
          messages = [lastMessage, ...messages];
        } else {
          String response = event.content?.parts?.fold(
                  '', (previous, current) => '$previous ${current.text}') ??
              '';
          ChatMessage message = ChatMessage(
            user: geminiUser,
            createdAt: DateTime.now(),
            text: response,
          );
          messages = [message, ...messages];
        }

        notifyListeners();
      });
    } catch (e) {
      // Handle errors here
      print('Error sending message: $e');
    }
  }

  Future<String> translateToUrdu(String text) async {
    try {
      Translation translation = await translator.translate(text, to: 'ur');
      return translation.text;
    } catch (e) {
      return text; // Return original text if translation fails
    }
  }
}
