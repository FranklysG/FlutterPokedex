import 'package:FlutterPokedex/consts/consts_app.dart';
import 'package:FlutterPokedex/models/pokeapi.dart';
import 'package:FlutterPokedex/pages/home_page/widgets/app_bar_home.dart';
import 'package:FlutterPokedex/pages/home_page/widgets/poke_item.dart';
import 'package:FlutterPokedex/pages/poke_detail/poke_detail_page.dart';
import 'package:FlutterPokedex/stores/pokeapi_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _pokemonStore = Provider.of<PokeApiStore>(context);
    if(_pokemonStore.pokeAPI == null){
      _pokemonStore.fetchPokemonList();
    }
    double screenWidth = MediaQuery.of(context).size.width;
    double statusWidth = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        overflow: Overflow.visible,
        children: <Widget>[
          // posicionando as imagens da pokeball
          Positioned(
            top: -(240 / 4),
            left: screenWidth - (240 / 1.5),
            child: Opacity(
              child: Image.asset(
                ConstsApp.blackPokeball,
                width: 250,
                height: 250,
              ),
              opacity: 0.1,
            ),
          ),
          // copo da home page
          Container(
            child: Column(
              children: <Widget>[
                // definindo uma safearea
                Container(
                  height: statusWidth,
                ),
                // widget da appbar
                AppBarHome(),
                Expanded(
                  child: Container(
                    child: Observer(
                      name: "ListaHomePage",
                      builder: (BuildContext context) {
                        return (_pokemonStore.pokeAPI != null)
                            ? AnimationLimiter(
                                child: GridView.builder(
                                  physics: BouncingScrollPhysics(),
                                  padding: EdgeInsets.all(12),
                                  addAutomaticKeepAlives: true,
                                  gridDelegate:
                                      new SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2),
                                  itemCount:
                                      _pokemonStore.pokeAPI.pokemon.length,
                                  itemBuilder: (context, index) {
                                    Pokemon pokemon = _pokemonStore.getPokemon(index: index);
                                    return AnimationConfiguration.staggeredGrid(
                                      position: index,
                                      duration: const Duration(milliseconds: 375),
                                      columnCount: 2,
                                      child: ScaleAnimation(
                                        child: GestureDetector(
                                          child: PokeItem(
                                            index: index,
                                            name: pokemon.name,
                                            num: pokemon.num,
                                            types: pokemon.type,
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        PokeDetailPage(index: index,),
                                                fullscreenDialog: true,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
