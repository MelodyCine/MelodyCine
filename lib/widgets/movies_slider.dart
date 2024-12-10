import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinemelody/details.dart';
import 'package:flutter/material.dart';
import 'package:cinemelody/constants.dart';

class MovieSlider extends StatelessWidget {
  const MovieSlider({
    super.key,
    required this.snapshot
  });

  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: CarouselSlider.builder(
          itemCount: snapshot.data!.length,
          options: CarouselOptions(
            height: 200,
            viewportFraction: 0.4,
          ),
          itemBuilder: (context, itemIndex, pageViewIndex) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(movie: snapshot.data[itemIndex],),),);
              },
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    child: Image.network(
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                        '${Constants.imagePath}${snapshot.data![itemIndex].posterPath}'),
                  )),
            );
          },
        ));
  }
}
