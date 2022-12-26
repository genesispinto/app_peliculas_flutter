import 'package:app_peliculas/models/models.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class CardSwiper extends StatelessWidget {

  final List<Movie> movies;

  const CardSwiper({
    super.key, 
    required this.movies});

  @override
  Widget build(BuildContext context) {


    final size =MediaQuery.of(context).size;

    if(movies.isEmpty){
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.5,
      // Swiper widget para carrousel de taarjetas
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        itemBuilder: (_, index) {

          final movie = movies[index];
          movie.heroID = 'swiper-${movie.id}';

          return  GestureDetector(
            //GestureDetector permite colocar el OnTap para navegar entre las tarjetas
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero(
              tag: movie.heroID!,
              child: ClipRRect(
                //ClipRRect permite agregar un borderRadius
                borderRadius: BorderRadius.circular(20),
                child:  FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.fullPosterImg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        ),
    );
  }
}