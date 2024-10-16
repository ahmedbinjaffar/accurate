import 'package:accurate/constants/asset_images.dart';
import 'package:accurate/screens/Youtube_screen/Yotube_screen.dart';
import 'package:accurate/screens/ai_screen/ai_screen.dart';
import 'package:accurate/screens/calender_screen/calender_screen.dart';
import 'package:accurate/screens/favourite_screen/favourite_screen.dart';
import 'package:accurate/screens/home/drawer_view/drawer_view.dart';
import 'package:accurate/screens/home/home_view/home2.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: AppClr.primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: GNav(
            tabBackgroundGradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppClr.gradientcolor1,
                AppClr.gradientcolor2,
                AppClr.gradientcolor3
              ],
            ),
            gap: 8,
            onTabChange: (page) {
              setState(() {
                currentIndex = page;
              });
            },
            padding: const EdgeInsets.all(5),
            tabs: const [
              GButton(
                icon: Icons.home,
                iconColor: Colors.white,
                text: "Home",
              ),
              GButton(
                icon: Icons.favorite,
                iconColor: Colors.white,
                text: "Favourite",
              ),
              GButton(
                icon: Icons.price_check,
                iconColor: Colors.white,
                text: "Catalog",
              ),
              GButton(
                icon: Icons.youtube_searched_for,
                iconColor: Colors.white,
                text: "Youtube",
              ),
              GButton(
                icon: Icons.message,
                iconColor: Colors.white,
                text: "AI",
              ),
            ],
          ),
        ),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: const [
          Stack(
            children: [DrawerScreen(), Home2()],
          ),
          FavouriteScreen(
            showBackButton: false,
          ),
          CalendarScreen(),
          YoutubeScreen(),
          AiScreen()
        ],
      ),
    );
  }
}
