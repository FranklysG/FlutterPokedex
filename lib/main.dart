import 'package:FlutterPokedex/stores/pokeapi_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'pages/home_page/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(  
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Poekdex',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      ),
      providers: <SingleChildWidget>[
        Provider<PokeApiStore>(
          create: (_) => PokeApiStore(),
        ),
      ],
    );
  }
}
