import 'package:FlutterPokedex/consts/consts_app.dart';
import 'package:FlutterPokedex/models/pokeapi.dart';
import 'package:FlutterPokedex/stores/pokeapi_store.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class PokeDetailPage extends StatefulWidget {
  final int index;

  PokeDetailPage({Key key, this.index}) : super(key: key);

  @override
  _PokeDetailPageState createState() => _PokeDetailPageState();
}

class _PokeDetailPageState extends State<PokeDetailPage> {
  PageController _pageController;
  Pokemon _pokemon;
  PokeApiStore _pokemonStore;
  MultiTrackTween _animation;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.index);
    _pokemonStore = GetIt.instance<PokeApiStore>();
    _pokemon = _pokemonStore.pokemonAtual;
    _animation = MultiTrackTween([
      Track("rotation").add(Duration(seconds: 5), Tween(begin: 0.0, end: 6.0),
          curve: Curves.linear)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: Observer(
            builder: (context) {
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
                backgroundColor: _pokemonStore.corPokemon,
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
            return Container(
              color: _pokemonStore.corPokemon,
            );
          }),
          Container(
            height: MediaQuery.of(context).size.height / 3,
          ),
          SlidingSheet(
            elevation: 0,
            cornerRadius: 30,
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
            padding: const EdgeInsets.only(top: 10),
            child: SizedBox(
              height: 300,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  _pokemonStore.setPokemonAtual(index: index);
                },
                itemCount: _pokemonStore.pokeAPI.pokemon.length,
                itemBuilder: (BuildContext context, int index) {
                  Pokemon _pokeItem = _pokemonStore.getPokemon(index: index);
                  return Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      ControlledAnimation(
                        playback: Playback.LOOP,
                        duration: _animation.duration,
                        tween: _animation,
                        builder: (context, animation) {
                          return Transform.rotate(
                            angle: animation['rotation'],
                            child: Hero(
                              tag: _pokeItem.name + 'rotation',
                              child: Opacity(
                                  opacity: 0.2,
                                  child: Image.asset(
                                    ConstsApp.whitePokeball,
                                    width: 250,
                                    height: 250,
                                  )),
                            ),
                          );
                        },
                      ),
                      Observer(
                        builder: (context) {
                          return AnimatedPadding(
                            duration: Duration(seconds: 1),
                            padding: EdgeInsets.all(
                                index == _pokemonStore.posicaoAtual ? 0 : 60),
                            curve: Curves.bounceInOut,
                            child: Hero(
                              tag: _pokeItem.name,
                              child: CachedNetworkImage(
                                width: 200,
                                height: 200,
                                placeholder: (context, url) => new Container(
                                  color: Colors.transparent,
                                ),
                                color: index == _pokemonStore.posicaoAtual
                                    ? null
                                    : Colors.black.withOpacity(0.2),
                                imageUrl:
                                    'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/${_pokeItem.num}.png',
                              ),
                            ),
                          );
                        },
                      ),
                    ],
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
