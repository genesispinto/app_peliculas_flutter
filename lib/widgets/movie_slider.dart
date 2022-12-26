import 'package:app_peliculas/models/models.dart';
import 'package:flutter/material.dart';

class MovieSlider extends StatefulWidget {

  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  const MovieSlider({
    super.key, 
    required this.movies, 
    this.title, 
    required this.onNextPage});

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
final ScrollController scrollController =  ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if(scrollController.position.pixels >= scrollController.position.maxScrollExtent-500){
        widget.onNextPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return 
      SizedBox(
      //width: double.infinity, para que el contenedor tome todo el ancho posible
      width: double.infinity,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(widget.title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('${widget.title}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ),

         Expanded(
          child: ListView.builder(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: widget.movies.length,
            itemBuilder: (_, index) => _MoviePoster(movie: widget.movies[index],)
              
            )
          )
        ]),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie movie;

  const _MoviePoster({
    required this.movie});

  @override
  Widget build(BuildContext context) {

    movie.heroID= '${movie.title}${movie.id}';

    return Container(
                width: 130,
                height: 190,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    GestureDetector(
                        onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
                        child: Hero(
                          tag: movie.heroID!,
                          child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FadeInImage(
                             placeholder: const AssetImage('assets/no-image.jpg'),
                             image: NetworkImage(movie.fullPosterImg),
                             width: 130,
                             height: 170,
                             fit: BoxFit.cover,
                            ),
                                              ),
                        ),
                    ),
                      const SizedBox(height: 5,),
                       Text(
                        movie.title,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      )
                  ],
                ),
              );
  }
}