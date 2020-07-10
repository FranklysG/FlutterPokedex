import 'package:flutter/material.dart';

class AppBarHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 13, right: 10),
                  child: IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text('Pokedex',
                    style: TextStyle(
                        fontFamily: 'Goole',
                        fontWeight: FontWeight.bold,
                        fontSize: 28)),
              ),
            ],
          )
        ],
      ),
      height: 120,
      // color: (Color.fromARGB(200, 240, 245, 210)),
    );
  }
}
