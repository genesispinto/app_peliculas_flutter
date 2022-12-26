import 'package:app_peliculas/providers/movies_provider.dart';
import 'package:app_peliculas/search/search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

 @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Peliculas en cines')),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: ()=> showSearch(context: context, delegate: MovieSearchDelegate()), 
            icon: const Icon(Icons.search)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            //tarjetas principales
            CardSwiper(movies: moviesProvider.onDisplayMovies),
            // Listado horizontal de peliculas
            MovieSlider(
            movies: moviesProvider.popularMovies,
            //title: 'Populares',
            onNextPage: () => moviesProvider.getPopularMovies()),
           
          ],
        ),
      )
    );
  }
}