import 'package:accurate/constants/asset_images.dart';
import 'package:accurate/constants/routes.dart';
import 'package:accurate/screens/favourite_screen/favourite_screen.dart';
import 'package:accurate/screens/home/drawer_view/about/about.dart';
import 'package:accurate/screens/home/drawer_view/social_media/social_media.dart';
import 'package:accurate/screens/home/drawer_view/technical_support/technical_support.dart';
import 'package:accurate/widgets/text/top_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue[300]!,
            Colors.blue[200]!,
          ], // Adjust these shades as needed
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 50, left: 40, bottom: 200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        AssetsImages.instance.logoimage,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const TopHeading(
                  title: "Welcome",
                  colour: Colors.white,
                )
              ],
            ),
            Column(
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                NewRow(
                  text: 'Social Media',
                  icon: Icons.interests,
                  onTap: () {
                    Routes.instance.push(
                      widget: const SocialMedia(),
                      context: context,
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                NewRow(
                  text: 'Technical Support',
                  icon: Icons.headset_mic,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TechnicalSupport(),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                NewRow(
                  text: 'Saved',
                  icon: Icons.favorite,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FavouriteScreen(
                          showBackButton: true,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                NewRow(
                  text: 'About',
                  icon: Icons.person,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const About(),
                      ),
                    );
                  },
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => const AlertDialog(
                    title: Text('Goodbye'),
                    content: Text('Goodbye! The app will now close.'),
                  ),
                );

                Future.delayed(const Duration(seconds: 2), () {
                  SystemNavigator.pop();
                });
              },
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.cancel,
                    color: AppClr.primaryColor.withOpacity(0.5),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Log out',
                    style:
                        TextStyle(color: AppClr.primaryColor.withOpacity(0.5)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const NewRow({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: Colors.transparent,
          // Add elevation or border for a more clickable appearance
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.13),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
