// ignore_for_file: deprecated_member_use

import 'package:accurate/constants/asset_images.dart';
import 'package:accurate/widgets/custom_shapes/containers/circular_container.dart';
import 'package:accurate/widgets/text/top_heading.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppClr.gradientcolor1.withOpacity(0.4),
                AppClr.gradientcolor2.withOpacity(0.4),
                AppClr.gradientcolor3.withOpacity(0.4),
              ],
            ),
          ),
          child: Stack(
            children: [
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
              Column(
                children: [
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const BackButton(
                          color: AppClr.primaryColor,
                        ),
                        const TopHeading(
                          title: "About",
                          colour: AppClr.primaryColor,
                        ),
                        Container(width: 39)
                      ],
                    ),
                  ),
                  //const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          AssetsImages.instance.logoimage,
                          width: 150,
                          height: 150,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Welcome to ACCURATE SCALE, a visionary company that embarked on its journey half a century ago with a profound passion and unwavering conviction. Our founders’ dreams were to bring forth the finest digital products to Pakistan, with aspirations that these innovations would eventually captivate the global market. From humble beginnings, we nurtured our ambitions, overcoming myriad challenges that paralleled scaling a formidable peak. Throughout our evolutionary journey, we have emerged triumphant against the odds, solidifying our position as one of Pakistan’s premier enterprises. The path we tread was akin to ascending an arduous mountain, requiring relentless determination and unparalleled resilience. However, these trials forged the foundation of our character, propelling us towards remarkable achievements that stand as a testament to human potential and unwavering dedication. Today, our products command unwavering trust from a loyal clientele. The faith bestowed upon us by our valued customers is the bedrock of our success, serving as a constant reminder of the responsibility we bear. Each product bearing the ACCURATE SCALE insignia is a manifestation of our commitment to excellence, meticulously crafted to meet the highest standards of quality and functionality. Through this channel, we aim to keep you informed about our diverse range of products. From their intricate calibrations to their innovative features, we provide comprehensive insights that empower you to make informed choices. Our dedication to transparency ensures that you have access to the knowledge needed to optimize your experience with our products. As we reflect on the remarkable journey spanning five decades, we express our gratitude to our customers, partners, and stakeholders who have been integral to our growth. With your continued support and our unyielding drive for innovation, we are poised to conquer new summits and redefine industry benchmarks. Join us on this exciting voyage as we continue to shape the digital landscape, not only in Pakistan but across the globe. At ACCURATE SCALE, your confidence fuels our triumphs, and together, we are sculpting a future where precision, technology, and trust converge seamlessly. We Establish ACCURATE SCALE Company 50 years ago, with the enthusiasm and belief that one day we will be able to introduce the best digital products to Pakistan and then to the whole world, we started from scratch and now despite of thousand difficulties, we are one of the few best companies in Pakistan, Of course, it was more difficult than climbing a mountain, but today customers are blindly believed on our products, and your confidence is our success, our this channel update you about our all products their calibrations settings and features.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: AppClr.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        // const SizedBox(height: 10),
                        // GestureDetector(
                        //   onTap: () async {
                        //     const url =
                        //         'https://www.linkedin.com/in/mohtashim-shaikh-5504b521b?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=ios_app';
                        //     if (await canLaunch(url)) {
                        //       await launch(url);
                        //     }
                        //   },
                        //   child: const Row(
                        //     children: [
                        //       Text(
                        //         'Developer: Mohtashim Shaikh',
                        //         textAlign: TextAlign.justify,
                        //         style: TextStyle(
                        //           color: AppClr.primaryColor,
                        //           fontSize: 16,
                        //           fontWeight: FontWeight.w500,
                        //           decoration: TextDecoration.underline,
                        //         ),
                        //       ),
                        //       SizedBox(width: 10),
                        //       Image(
                        //         image: AssetImage(
                        //             'assets/images/LinkedIn_logo_initials.png'),
                        //         width: 17,
                        //         height: 17,
                        //       )
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
