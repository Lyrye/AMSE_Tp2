import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DisplayImage extends StatelessWidget {

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