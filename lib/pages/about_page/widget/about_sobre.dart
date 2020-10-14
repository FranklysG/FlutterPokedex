import 'package:FlutterPokedex/models/specie.dart';
import 'package:FlutterPokedex/stores/pokeapi_store.dart';
import 'package:FlutterPokedex/stores/pokeapiv2_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class AbaSobre extends StatelessWidget {
  final PokeApiV2Store _pokeApiV2Store = GetIt.instance<PokeApiV2Store>();
  final PokeApiStore _pokemonStore = GetIt.instance<PokeApiStore>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Descrição",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Observer(builder: (context) {
            Specie _specie = _pokeApiV2Store.specie;
            return _specie != null
                ? Text(
                    _specie.flavorTextEntries
                        .where((item) => item.language.name == "en")
                        .first
                        .flavorText,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  )
                : SizedBox(
                    height: 15,
                    width: 15,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          _pokemonStore.corPokemon),
                    ),
                  );
          }),
        ],
      ),
    );
  }
}
