import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../services/themeProvider.dart';
import '../services/utils.dart';

class SliderCard extends StatefulWidget {
  const SliderCard({super.key});

  @override
  State<SliderCard> createState() => _SliderCard();
}

class _SliderCard extends State<SliderCard> {
  final List<String> _images = [
    "lib/images/dailymotion.png",
    "lib/images/facebook.png",
    "lib/images/tiktok.png",
    "lib/images/youtube.png",
    "lib/images/soundcloud.png",
    "lib/images/buzzfeed.png",
    "lib/images/tum.png",
    "lib/images/espn.png",
    "lib/images/vimeo.png"
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final sizeScreen = Utils(context).getScreenSize;
    return SizedBox(
      height: sizeScreen.height * 0.3,
      child: Center(
          // child: Container(
          //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(60)),
          //   child: Swiper(
          //     itemBuilder: (BuildContext context, int index) {
          //       return Image.asset(
          //         _images[index],
          //         fit: BoxFit.fill,
          //       );
          //     },
          //     itemCount: _images.length,
          //     // pagination: SwiperPagination(),
          //     // control: SwiperControl(),
          //     autoplay: true,
          //   ),
          // ),
          ),
    );
  }
}
