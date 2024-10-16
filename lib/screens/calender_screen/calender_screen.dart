import 'package:accurate/firebase_helper/firebase_firestore/firebase_firestore.dart';
import 'package:accurate/models/calendar_model/calendar_model.dart';
import 'package:accurate/screens/calender_screen/widgets/image_card.dart';
import 'package:accurate/widgets/custom_shapes/containers/circular_container.dart';
import 'package:accurate/widgets/text/top_heading.dart';
import 'package:flutter/material.dart';

import '../../constants/asset_images.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  List<CalendarModel> calendarModelList = [];
  //List<YoutubeModel> filteredList = [];
  bool isLoading = false;

  TextEditingController searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    getYoutubeList();
  }

  void getYoutubeList() async {
    setState(() {
      isLoading = true;
    });
    calendarModelList = await FirebaseFirestoreHelper.instance.getCalendar();
    //filteredList = youtubeModelList;
    setState(() {
      isLoading = false;
    });
  }

  // void searchFun(String value) {
  //   setState(() {
  //     filteredList = youtubeModelList
  //         .where((youtubeVideo) =>
  //             youtubeVideo.name.toLowerCase().contains(value.toLowerCase()))
  //         .toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppClr.gradientcolor1.withOpacity(0.4),
                    AppClr.gradientcolor2.withOpacity(0.4),
                    AppClr.gradientcolor3.withOpacity(0.4)
                  ]),
            ),
            child: Stack(children: [
              Positioned(
                top: -150,
                right: -250,
                child: circularContainer(
                  backgroundcolor:
                      const Color.fromARGB(255, 103, 184, 250).withOpacity(0.2),
                ),
              ),
              Positioned(
                top: 100,
                right: -300,
                child: circularContainer(
                  backgroundcolor:
                      const Color.fromARGB(255, 103, 184, 250).withOpacity(0.2),
                ),
              ),
              Column(children: [
                const SizedBox(height: 50),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TopHeading(
                          title: "Catalog",
                          colour: AppClr.primaryColor,
                        ),
                      ]),
                ),
              ]),
              Column(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: calendarModelList.length,
                        itemBuilder: (ctx, index) {
                          final CalendarModel singleCalendar =
                              calendarModelList[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              children: [ImageCard(url: singleCalendar.image)],
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ])));
  }
}
