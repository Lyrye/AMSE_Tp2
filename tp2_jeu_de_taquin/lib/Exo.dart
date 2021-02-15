

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Exercice1 extends StatelessWidget {

    Widget build(BuildContext context)
    {
      var mediaQueryData = MediaQuery.of(context);

      return Container(
        height:mediaQueryData.size.height - 200 ,
        child:Image.network("https://picsum.photos/512/1024"),
      );
    }
}
