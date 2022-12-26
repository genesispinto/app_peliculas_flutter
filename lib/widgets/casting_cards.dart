import 'package:app_peliculas/models/models.dart';
import 'package:app_peliculas/providers/movies_provider.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {

  final int movieId;
  const CastingCards({
    super.key,  required this.movieId});

  @override
  Widget build(BuildContext context) {

    final moviesProvider= Provider.of<MoviesProvider>(context,listen: false);

   return FutureBuilder<List<Cast>>(
          future: moviesProvider.getMovieCast(movieId),
          builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
        if (snapshot.hasData) {

          final cast = snapshot.data!;

          return  Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 180,
          child: ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index)=> _CastCard(actor: cast[index]))),
        );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

    // By default, show a loading spinner.
    return const CupertinoActivityIndicator();
  },
);
   
  }
}

class _CastCard extends StatelessWidget {

  final Cast actor;
  
  const _CastCard({required this.actor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child:  FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage('${actor.fullprofilePath}'),
                fit: BoxFit.cover,
                height: 140,
                width: 100,
              ),
          ),
        const SizedBox(height: 5,),
        Text(actor.name,
         maxLines: 2, 
         overflow: TextOverflow.ellipsis,
         textAlign: TextAlign.center,
         )
      ]),
    );
  }
}