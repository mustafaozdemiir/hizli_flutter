import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';

class SwiperOrnek extends StatefulWidget {
  @override
  _SwiperOrnekState createState() => _SwiperOrnekState();
}

class _SwiperOrnekState extends State<SwiperOrnek> {
  List<String> images = [
    "https://images.pexels.com/photos/6561413/pexels-photo-6561413.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
    "https://images.pexels.com/photos/3375920/pexels-photo-3375920.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
    "https://images.pexels.com/photos/4784955/pexels-photo-4784955.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: Get.width * 0.75,
        height: Get.height * 0.6,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Image.network(
              images[index],
              fit: BoxFit.fill,
            );
          },
          itemCount: images.length,
          autoplay: true,
          viewportFraction: 0.8,
          scale: 0.9,
          itemWidth: Get.width * 0.6,
          layout: SwiperLayout.STACK,
          pagination: SwiperPagination(),
          control: SwiperControl(),
        ),
      ),
    );
  }
}
