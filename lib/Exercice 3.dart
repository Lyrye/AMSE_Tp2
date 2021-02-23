
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Exercice 1.dart';
import 'Exercice 2.dart';
import 'Exercice 4.dart';
import 'Exercice 5.dart';
import 'Exercice 6.dart';

class DisplayExercice extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(child:
        ListTile(
          title: Text("Exercice 1"),
          subtitle: Text("Affichage d'une image"),
          leading: Icon(Icons.wb_sunny_outlined),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>DisplayImage()));
          },)),
        Card(child:
        ListTile(
          leading: Icon(Icons.wb_sunny_outlined),
          title: Text("Exercice 2"),
          subtitle: Text("Rotation, taille et mode miroir"),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>RotateResizeMirrorWidget()));
          },)),
        Card(child:
        ListTile(
          leading: Icon(Icons.wb_sunny_outlined),
          title: Text("Exercice 4"),
          subtitle: Text("Affichage d'une tuile a a partir d'une image"),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>DisplayTileWidget()));
          },)),
        Card(child:
        ListTile(
          leading: Icon(Icons.wb_sunny_outlined),
          title: Text("Exercice 5"),
          subtitle: Text("Affichage d'une grille modulable de tuile a partir d'un image"),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageGridViewTile()));
          },)),
        Card(child:
        ListTile(
          leading: Icon(Icons.wb_sunny_outlined),
          title: Text("Exercice 6"),
          subtitle: Text("Affichage d'une tuile a a partir d'une image"),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>PositionedTiles()));
          },))
      ],

    );
  }


}
