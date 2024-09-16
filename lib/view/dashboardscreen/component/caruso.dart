import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:kelompok5_a2/helper/images.dart';
import 'package:kelompok5_a2/helper/theme.dart';

class MyCarousel extends StatelessWidget {
  const MyCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bg1Color,
        borderRadius: const BorderRadius.all(
          Radius.circular(0),
        ),
        border: Border.all(
          color: bg1Color,
          width: 3,
        ),
      ),
      child: CarouselSlider(
        items: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 10 / 100,
            decoration: BoxDecoration(
              color: bg2Color,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              border: Border.all(
                color: bg1Color,
                width: 3,
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(0),
              ),
              child: Image.asset(
                Images.iklanbaju1,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 10 / 100,
            decoration: BoxDecoration(
              color: bg2Color,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              border: Border.all(
                color: bg1Color,
                width: 3,
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(0),
              ),
              child: Image.asset(
                Images.iklandres1,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 10 / 100,
            decoration: BoxDecoration(
              color: bg2Color,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              border: Border.all(
                color: bg1Color,
                width: 3,
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(0),
              ),
              child: Image.asset(
                Images.iklanrok1,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 10 / 100,
            decoration: BoxDecoration(
              color: bg2Color,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              border: Border.all(
                color: bg1Color,
                width: 3,
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(0),
              ),
              child: Image.asset(
                Images.iklanrok2,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height * 30 / 100,
          enlargeCenterPage: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 2),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.linear,
          enableInfiniteScroll: true,
          aspectRatio: 16 / 9,
          viewportFraction: 1,
        ),
      ),
    );
  }
}
