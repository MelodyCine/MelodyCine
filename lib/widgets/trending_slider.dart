import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinemelody/constants.dart';
import 'package:cinemelody/details.dart';
import 'package:flutter/material.dart';
import 'package:cinemelody/details.dart';

class TrendingSlider extends StatelessWidget {
  const TrendingSlider({
    super.key,
    required this.snapshot,
  });

  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: CarouselSlider.builder(
          itemCount: 10,
          options: CarouselOptions(
              height: 140,
              autoPlay: true,
              viewportFraction: 0.55,
              enlargeCenterPage: true,
              pageSnapping: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlayAnimationDuration: const Duration(seconds: 2)),
          itemBuilder: (context, itemIndex, pageViewIndex) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(movie: snapshot.data[itemIndex],),),);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                    width: 250,
                    '${Constants.imagePath}${snapshot.data[itemIndex].backdropPath}'),
              ),
            );
          },
        ));
  }
}
