import 'dart:io';

import 'package:app_peliculas/providers/movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:app_peliculas/screens/screens.dart';
import 'package:provider/provider.dart';



void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const AppState());
} 
  





class AppState extends StatelessWidget {
  const AppState({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((_) => MoviesProvider()), lazy: false,)
      ],
      child: const MyApp(),);
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: 'home',
      routes: {
        'home': ((context) => const HomeScreen()),
        'details': ((context) => const DetailsScreen())

      },
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo
        )
      )
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}