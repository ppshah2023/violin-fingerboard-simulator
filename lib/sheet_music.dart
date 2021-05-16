import 'package:flutter/material.dart';
import 'package:sheet_music/example.dart';
import 'package:sheet_music/sheet_music.dart';

class Notator extends StatefulWidget {
  @override
  _NotatorState createState() => _NotatorState();
}

class _NotatorState extends State<Notator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SheetMusic(trebleClef: true, scale: "C", pitch: "C4"),
    );
  }
}
