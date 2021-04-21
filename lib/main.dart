import 'package:flutter/material.dart';
import 'package:note_app/Screens/NoteList.dart';
import 'package:note_app/Screens/NoteDetail.dart';
void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
        primarySwatch: Colors.deepOrange
      ),
      home: NoteList(),
    );

      }
}

