import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class Exercice1 extends StatelessWidget {

  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(

          title: Text("Exercice 1"),
        ),
        body: Center(
          child: Container(
              height: mediaQueryData.size.height - 200,
              child: Image.network("https://picsum.photos/512/1024")),
        )
    );
  }
}

class Exercice2 extends StatefulWidget {

  @override
  _Exercice2State createState() => _Exercice2State();
}

class _Exercice2State extends State<Exercice2> {
  double _currentSlider1Value = 0.0;
  double _currentSlider2Value = 0.0;
  double _currentSlider3Value = 100.0;
  bool _mirror = false;
  Image image = Image.network("https://picsum.photos/512/1024");
  double _size;

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);

    return Scaffold(
        appBar: AppBar(

          title: Text("Exercice 1"),
        ),
        body: Center(
            child:
            ListView(
                children: [
                  Container(
                    height: mediaQueryData.size.height * (2 / 3),
                    width: mediaQueryData.size.width,
                    child: Transform(
                        origin: Offset(mediaQueryData.size.width / 2,
                            mediaQueryData.size.height * (2 / 3) / 2),
                        transform: Matrix4(
                          1, 0, 0, 0, // scale X
                          0, 1, 0, 0, // scale Y
                          0, 0, 1, 0,
                          0, 0, 0, (1 / (_currentSlider3Value / 100)), // scale X&Y
                        )
                          ..rotateX(math.pi / 180 * _currentSlider1Value)
                          ..rotateY(_mirror ? math.pi : 0)
                          ..rotateZ(math.pi / 180 * _currentSlider2Value),

                        child: Image.network("https://picsum.photos/512/1024")),
                  ),
                  Row(
                    children: [
                      Container(
                          width: mediaQueryData.size.width / 8,
                          child:
                          Text("Rotation X")),
                      Container(
                        width: mediaQueryData.size.width * (7 / 8),
                        child: Slider(
                            value: _currentSlider1Value,
                            min: 0,
                            max: 360,
                            divisions: 360,
                            label: _currentSlider1Value.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                _currentSlider1Value = value;
                              });
                            }),)
                    ],
                  ),
                  Row(
                      children: [
                        Container(
                          width: mediaQueryData.size.width / 8,
                          child: Text("Rotation Y"),
                        ),
                        Container(
                            width: mediaQueryData.size.width * (7 / 8),
                            child:
                            Slider(
                              value: _currentSlider2Value,
                              min: 0,
                              max: 360,
                              divisions: 360,
                              label: _currentSlider2Value.round().toString(),
                              onChanged: (double value) {
                                setState(() {
                                  _currentSlider2Value = value;
                                });
                              },
                            )
                        ),
                      ]
                  ),
                  Row(
                      children: [
                        Container(
                          width: mediaQueryData.size.width / 8,
                          child: Text("Taille"),
                        ),
                        Container(
                            width: mediaQueryData.size.width * (7 / 8),
                            child: Slider(
                              value: _currentSlider3Value,
                              min: 0,
                              max: 100,
                              divisions: 100,
                              label: _currentSlider3Value.round().toString(),
                              onChanged: (double value) {
                                setState(() {
                                  _currentSlider3Value = value;
                                });
                              },
                            )
                        )
                      ]
                  ),
                  Row(children: [
                    Container(
                      width: mediaQueryData.size.width / 7,
                      child: Text("Miroir"),),
                    Container(
                        child: Checkbox(
                          value: _mirror,
                          onChanged: (value) {
                            setState(() {
                              _mirror = !_mirror;
                            }
                            );
                          },
                        )
                    )
                  ]
                  ),
                ]
            )
        ));
  }
}

  class Exercice3 extends StatelessWidget{
    @override
    Widget build(BuildContext context) {
      return ListView(
        children: [
          Card(child:
            ListTile(
              title: Text("Exercice 1"),
              subtitle: Text("Affichage d'une image"),
              leading: Icon(Icons.play_arrow_rounded),
              onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Exercice1()));
          },)),
          Card(child:
            ListTile(
              leading: Icon(Icons.play_arrow_rounded),
              title: Text("Exercice 2"),
              subtitle: Text("Rotation, taille et mode miroir"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Exercice2()));
              },))
        ],

      );
    }


  }

  class Exercice4 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          title: Text("Exercice 1"),
        ),
        body: Center(
          child: Container(
              child: Image.network("https://picsum.photos/512/1024")),
        )
    );
  }


  }


