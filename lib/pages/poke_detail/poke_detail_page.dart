import 'package:FlutterPokedex/consts/consts_app.dart';
import 'package:FlutterPokedex/models/pokeapi.dart';
import 'package:FlutterPokedex/stores/pokeapi_store.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class PokeDetailPage extends StatelessWidget {
  final int index;

  Color _corPokemon;

  PokeDetailPage({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _pokemonStore = Provider.of<PokeApiStore>(context);
    Pokemon _pokemon = _pokemonStore.pokemonAtual;
    _corPokemon = ConstsApp.getColorType(type: _pokemon.type[0]);
    return Scaffold(
      appBar: PreferredSize(
          child: Observer(
            builder: (context) {
              _corPokemon = ConstsApp.getColorType(
                type: _pokemonStore.pokemonAtual.type[0]);
              return AppBar(
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
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                actions: <Widget>[
                  IconButton(icon: Icon(Icons.favorite), onPressed: null),
                ],
              );
            },
          ),
          preferredSize: Size.fromHeight(50)),
      body: Stack(
        children: <Widget>[
          Observer(builder: (context) {
            _corPokemon = ConstsApp.getColorType(
                type: _pokemonStore.pokemonAtual.type[0]);
            return Container(
              color: _corPokemon,
            );
          }),
          Container(
            height: MediaQuery.of(context).size.height / 3,
          ),
          SlidingSheet(
            elevation: 0,
            cornerRadius: 16,
            snapSpec: const SnapSpec(
              snap: true,
              snappings: [0.7, 1.0],
              positioning: SnapPositioning.relativeToAvailableSpace,
            ),
            builder: (context, state) {
              return Container(
                height: MediaQuery.of(context).size.height,
                child: Container(),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: SizedBox(
              height: 200,
              child: PageView.builder(
                onPageChanged: (index) {
                  _pokemonStore.setPokemonAtual(index: index);
                },
                itemCount: _pokemonStore.pokeAPI.pokemon.length,
                itemBuilder: (BuildContext context, int index) {
                  Pokemon _pokeItem = _pokemonStore.getPokemon(index: index);
                  return CachedNetworkImage(
                    width: 150,
                    height: 150,
                    placeholder: (context, url) => new Container(
                      color: Colors.transparent,
                    ),
                    imageUrl:
                        'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/${_pokeItem.num}.png',
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
