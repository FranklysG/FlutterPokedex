import 'package:FlutterPokedex/consts/consts_app.dart';
import 'package:FlutterPokedex/models/pokeapi.dart';
import 'package:FlutterPokedex/stores/pokeapi_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PokeDetailPage extends StatefulWidget {
  final int index;
  final String name;


  PokeDetailPage({Key key, this.index, this.name}) : super(key: key);

  @override
  _PokeDetailPageState createState() => _PokeDetailPageState();
}

class _PokeDetailPageState extends State<PokeDetailPage> {
  Color _corPokemon;

  @override
  Widget build(BuildContext context) {
    final _pokemonStore = Provider.of<PokeApiStore>(context);
    Pokemon _pokemon = _pokemonStore.getPokemon(index: this.widget.index);
    _corPokemon = ConstsApp.getColorType(type: _pokemon.type[0]);
    return Scaffold(
      appBar: AppBar(
        title: Opacity(
          opacity: 0.0,
          child: Text(
            _pokemon.name,
            style: TextStyle(
              fontFamily: 'Google',
              fontWeight: FontWeight.bold,
              fontSize: 21,
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: _corPokemon,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.favorite), onPressed: null),
        ],
      ),
      backgroundColor: _corPokemon,
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height / 3,
          ),
        ],
      ),
    );
  }
}
