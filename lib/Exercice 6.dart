import 'package:flutter/material.dart';
import 'dart:math' as math;
// ==============
// Models
// ==============

math.Random random = new math.Random();

class Tile {
  Color color;
  int index;

  Tile(this.color, this.index);

  Tile.randomColor(int index) {
    this.color = Color.fromARGB(
        255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
    this.index = index;
  }
}

class TileWidget extends StatelessWidget {
  final Tile tile;

  TileWidget(this.tile);



  @override
  Widget build(BuildContext context) {
    return this.coloredBox();
  }
  Widget coloredBox() {
    return Container(
        color: tile.color,
        child:Align(
          alignment: Alignment.center,
          child: Text(tile.index.toString(), style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        )
    );
  }
}

void main() => runApp(new MaterialApp(home: PositionedTiles()));

class PositionedTiles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PositionedTilesState();
}

class PositionedTilesState extends State<PositionedTiles> {
  int indexSwap = 0;

  GridView createGridView(List <Widget> _listTile, int value ){

    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: value,
          crossAxisSpacing: 2.0,
          mainAxisSpacing: 2.0
        ),
        itemCount: value * value,
        itemBuilder: (BuildContext context, int index)
          { if (index == indexSwap) {
            return Container(

              child: TileWidget(new Tile(Colors.white, 0)),
            );
          } else
            {
              return Container (
                  child: InkWell(
                     child: _listTile[index],
                    onTap: ()
                    {
                      if (index == indexSwap -1 || index == indexSwap +1 || index == indexSwap -_currentSliderValue || index == indexSwap +_currentSliderValue )
                      {
                        swapTiles(index, indexSwap);
                      }
                    },
                )
              );
            }
          }
        );
  }

  int _currentSliderValue = 3;

  List<Widget> tiles = List<Widget>.generate(10*10, (index) => TileWidget(Tile.randomColor(index)));

  Widget build(BuildContext context) {

    var mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Exercice 6'),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 500,
            width: 400,
            child:Container(
                child: createGridView(tiles,_currentSliderValue)
            ),
          ),
          Container(
            width: mediaQueryData.size.width * (7 / 8),
            child: Slider(
                value: _currentSliderValue.toDouble(),
                min: 2,
                max: 10,
                divisions: 9,
                label: _currentSliderValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    indexSwap = 0;
                    _currentSliderValue = value.toInt();
                  });
                }),)
        ],)


    );
  }

  swapTiles(int index1, int emptyIndex) {
    setState(() {
      print("Button pressed");
      tiles.insert(index1, tiles.removeAt(emptyIndex));
      if (index1 == _currentSliderValue+emptyIndex)
        {
          tiles.insert(emptyIndex, tiles.removeAt(index1-1));
        }
      if (index1 == emptyIndex -_currentSliderValue)
        {
          tiles.insert(emptyIndex, tiles.removeAt(index1+1));
        }
      indexSwap = index1;
    });
  }

}