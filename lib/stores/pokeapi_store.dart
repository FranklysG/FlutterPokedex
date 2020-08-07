import 'dart:convert';
import 'package:FlutterPokedex/consts/consts_api.dart';
import 'package:FlutterPokedex/consts/consts_app.dart';
import 'package:FlutterPokedex/models/pokeapi.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
part 'pokeapi_store.g.dart';

class PokeApiStore = _PokeApiStoreBase with _$PokeApiStore;

abstract class _PokeApiStoreBase with Store {
  
@observable
PokeAPI _pokeAPI;

@observable
Pokemon _pokemonAtual;

@observable
dynamic corPokemon;

@observable
int posicaoAtual;

@computed
PokeAPI get pokeAPI => _pokeAPI;

@computed
Pokemon get pokemonAtual => _pokemonAtual;

@action
fetchPokemonList(){
  _pokeAPI = null;
  loadPokeAPI().then((pokeList){
    _pokeAPI = pokeList;
  });
}

Pokemon getPokemon({int index}){
  return _pokeAPI.pokemon[index];
}

@action
 Widget getImage({String numero}){
    return CachedNetworkImage(
      placeholder: (context, url) => new Container(
        color: Colors.transparent,
      ),
      imageUrl: 'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$numero.png',
    );
  }

@action
setPokemonAtual({int index}){
  _pokemonAtual = _pokeAPI.pokemon[index];
  corPokemon = ConstsApp.getColorType(type: _pokemonAtual.type[0]);
  posicaoAtual = index;
}

  Future<PokeAPI> loadPokeAPI() async {
    try{
      final response = await http.get(ConstsAPI.pokeapiURL);
      var decodeJson = jsonDecode(response.body);
      return PokeAPI.fromJson(decodeJson);
    }catch(erro){
      print("Erro ao carregar lista");
      return null;
    }

  }

 


}