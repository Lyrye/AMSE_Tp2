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

////////////////////////////////////////////////////////////////////////Exo5//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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
                    child: GridView.count(
                      children: createWidgetList(_listTile, _currentSliderValue),
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                          crossAxisCount: _currentSliderValue,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                  ),
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