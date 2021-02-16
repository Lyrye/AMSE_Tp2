import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Tile {
  String imageURL;
  Alignment alignment;
  String imageGenerator = "https://picsum.photos/512";

  Tile({this.imageURL, this.alignment});

  Widget croppedImageTile() {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: ClipRect(
        child: Container(
          child: Align(
            alignment: this.alignment,
            widthFactor: 0.3,
            heightFactor: 0.3,
            child: Image.network(this.imageURL),
          ),
        ),
      ),
    );
  }
}

Tile tile = new Tile(
    imageURL: "https://picsum.photos/512", alignment: Alignment(0, 0));

class DisplayTileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercice 4'),
      ),
      body: Center(
          child: Column(children: [
            SizedBox(
                width: 150.0,
                height: 150.0,
                child: Container(
                    margin: EdgeInsets.all(20.0),
                    child: this.createTileWidgetFrom(tile))),
            Container(
                height: 200,
                child: Image.network("https://picsum.photos/512",
                    fit: BoxFit.cover))
          ])),
    );
  }

  Widget createTileWidgetFrom(Tile tile) {
    return InkWell(
      child: tile.croppedImageTile(),
      onTap: () {
        print("tapped on tile");
      },
    );
  }
}