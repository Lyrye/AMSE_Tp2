import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TileUp {
  String imageURL;
  Alignment alignment;

  TileUp({this.imageURL, this.alignment});

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

class ImageGridViewTile extends StatefulWidget{
  @override
  _ImageGridViewTileState createState() => _ImageGridViewTileState();
}

class _ImageGridViewTileState extends State<ImageGridViewTile> {
  int _currentSliderValue = 3;

  String imageURL = "https://picsum.photos/512";
  List <TileUp> _listTile = <TileUp>[];

  List <TileUp> createListTile ()
  {
    double pas = (2/((_currentSliderValue-1)));
    List <TileUp> _listTile = <TileUp>[];
    double i;
    double j;
    for(i = -1 ; i <=1; i+=pas)
    {
      for (j=-1; j<=1; j +=pas) {
        _listTile.add(new TileUp(
            imageURL: imageURL,
            alignment:Alignment(j, i)));
      }
    }
    return _listTile;
  }
  Widget createTileUpWidgetFrom(TileUp tile, int size) {
    return InkWell(
      child: tile.croppedImageTile(size),
      onTap: () {
        print("tapped on tile");
      },
    );
  }

  List<Widget> createWidgetList(List<TileUp> lt,int size){
    List<Widget> lw =<Widget>[];
    for(int i=0;i<lt.length;i++){
      lw.add(createTileUpWidgetFrom(lt[i], size));
    }
    return lw;
  }

  Widget creatGridView(List <TileUp> _listTile, int value)
  {
    return GridView.count(
      children: createWidgetList(_listTile, value),
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      crossAxisCount: value,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
    );
  }


  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    _listTile = createListTile();

    return Scaffold(
        appBar: AppBar(
          title: Text("Exercice 5"),
        ),
        body: Center(
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 500,
                  width: 400,
                  child:Container(
                    child: creatGridView(_listTile,_currentSliderValue)
                  ),
                ),
                Container(
                  width: mediaQueryData.size.width * (7 / 8),
                  child: Slider(
                      value: _currentSliderValue.toDouble(),
                      min: 1,
                      max: 10,
                      divisions: 10,
                      label: _currentSliderValue.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue = value.toInt();
                        });
                      }),)
              ],
            )
        )
    );
  }


}