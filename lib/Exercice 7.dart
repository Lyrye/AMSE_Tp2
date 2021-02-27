import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';


class TileUp {
  String imageURL;
  Alignment alignment;
  int index;

  TileUp({this.imageURL, this.alignment, this.index});
  int getIndex ()
  {
    return this.index;
  }

  Widget croppedImageTile(int size) {
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Container(
          child: Align(
            alignment: this.alignment,
            widthFactor: 1/size,
            heightFactor: 1/size,
            child: Image.network(this.imageURL),
          ),
        ),
      ),
    );
  }
}

class TileWidget extends StatelessWidget
{
  TileUp tile;
  int size;
  @override
  TileWidget(this.tile, this.size);

  Widget build(BuildContext context) {

    return Container (
      child: tile.croppedImageTile(size)
    );
  }

}
List <TileUp> createListTile (int value, String imageURL)
{
  double pas = (2/((value-1)));
  List <TileUp> _listTile = <TileUp>[];
  double i;
  double j;
  int index = 0;
  for(i = -1 ; i <=1; i+=pas)
  {
    for (j=-1; j<=1; j +=pas) {
      _listTile.add(new TileUp(
          imageURL: imageURL,
          alignment:Alignment(j, i),index: index));
      index ++;
    }
  }
  return _listTile;
}

List<Widget> createWidgetList(List<TileUp> lt,int size){
  List<Widget> lw =<Widget>[];
  for(int i=0;i<lt.length;i++){
    lw.add(new TileWidget(lt[i], size));
  }
  return lw;
}

class ImageGridViewTileSwap extends StatefulWidget{
  @override
  _ImageGridViewTileSwapState createState() => _ImageGridViewTileSwapState();
}

class _ImageGridViewTileSwapState extends State<ImageGridViewTileSwap> {
  int sizeofGrid = 3;
  double difficulty = 1;
  String imageURL = "https://picsum.photos/512";
  List <TileUp> _listTile = createListTile(3, "https://picsum.photos/512");
  List <Widget> _listTileWidget = createWidgetList(
      createListTile(3, "https://picsum.photos/512"), 3);
  int indexSwap = 0;
  bool isWin = false;
  int nbDeplacement = 0;
  TextStyle style = TextStyle(fontSize: 20, color: Colors.deepPurple);

  GridView creatGridView(List <Widget> _listTile, int value) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: value,
            crossAxisSpacing: 2.0,
            mainAxisSpacing: 2.0
        ),
        itemCount: value * value,
        itemBuilder: (BuildContext context, int index) {
          if (index == indexSwap) {
            return Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black,
                        width: 2)
                ),
                child: Container(
                  color: Colors.white,
                )
            );
          }
          else {
            return Container(
                child: InkWell(
                  child: _listTile[index],
                  onTap: () {
                    if (index == indexSwap - 1 || index == indexSwap + 1 ||
                        index == indexSwap - sizeofGrid ||
                        index == indexSwap + sizeofGrid) {
                      swapTiles(index, indexSwap);
                    }
                    isWin = win();
                  },
                )
            );
          }
        }
    );
  }

  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Exercice 7 - Jeu du taquin"),
        ),
        body: Center(
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                Container (
                  child: Align(
                      alignment: Alignment.center ,
                      child: Text("Nombre de déplacement", style: style)),
                ),
                Container(
                  child: Align(
                    alignment: Alignment.center,
                      child:Text(nbDeplacement.toString(),style: style),)
                ),
                SizedBox(
                  height: 500,
                  width: 400,
                  child: Container(
                      child: creatGridView(_listTileWidget, sizeofGrid)
                  ),
                ),
                isWin?Container(
                    child: Align (
                      alignment: Alignment.center,
                        child: Text("Gagné!",style: TextStyle(fontSize: 30, color: Colors.blue))
                  )
                ): Container(),
                Container(
                    child: Align(
                      alignment: Alignment.center ,
                      child: Text("Taille de l'image",
                        style: TextStyle(fontSize: 20, color: Colors.deepPurple)),)
                ),
                Container(
                  width: mediaQueryData.size.width * (7 / 8),
                  child: Slider(
                      value: sizeofGrid.toDouble(),
                      min: 2,
                      max: 10,
                      divisions: 9,
                      label: sizeofGrid.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          indexSwap = 0;
                          sizeofGrid = value.toInt();
                          _listTile = createListTile(sizeofGrid, "https://picsum.photos/512");
                          _listTileWidget = createWidgetList(_listTile, sizeofGrid);
                          isWin= false;
                        });
                      }),),
                Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Difficulté",
                    style: TextStyle(fontSize: 20, color: Colors.deepPurple)),)
                ),
                Container(
                  width: mediaQueryData.size.width * (7 / 8),
                  child: Slider(
                      value: difficulty,
                      min: 1,
                      max: 5,
                      divisions: 4,
                      label: difficulty.toString(),
                      onChanged: (double value) {
                        setState(() {
                          difficulty = value;
                        });
                      }
                    ),
                ),
              ],
            )
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            mixTiles((difficulty.toInt()^difficulty.toInt()*20)*200);
            isWin = false;
            nbDeplacement = 0;
          },
          child: Icon(Icons.play_arrow_rounded),
          backgroundColor: Colors.deepPurple,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked

    );
  }

  swapTiles(int index1, int emptyIndex) {
    setState(() {
      nbDeplacement ++;
      _listTileWidget.insert(index1, _listTileWidget.removeAt(emptyIndex));
      if (index1 == sizeofGrid + emptyIndex) {
        _listTileWidget.insert(emptyIndex, _listTileWidget.removeAt(index1 - 1));
      }
      if (index1 == emptyIndex - sizeofGrid) {
        _listTileWidget.insert(emptyIndex, _listTileWidget.removeAt(index1 + 1));
      }
      indexSwap = index1;
    });
  }

  mixTiles(int mixMovement) {
    Random random = new Random ();
    int rng = random.nextInt(3);
    int mouvement;
    indexSwap = random.nextInt(sizeofGrid*sizeofGrid);
    for (int i = 0; i < mixMovement; i++) {
      rng = random.nextInt(3);
      switch (rng) {
        case 0:
          mouvement = indexSwap + 1;
          break;
        case 1:
          mouvement = indexSwap - 1;
          break;
        case 2:
          mouvement = indexSwap - sizeofGrid;
          break;
        case 3:
          mouvement = indexSwap + sizeofGrid;
      }

      if (mouvement > (sizeofGrid * sizeofGrid) - 1 ||
          mouvement < 0) {
        mouvement = indexSwap;
      }
      swapTiles(mouvement, indexSwap);
    }
  }

  bool win()
  {
    TileWidget tileWidget;
    bool isWin = true;
    for (int i =0; i<sizeofGrid*sizeofGrid; i++)
      {
        tileWidget = _listTileWidget[i];
        if ( tileWidget.tile.index != i )
          {
            isWin = false;
          }
      }
    return isWin;
  }
}