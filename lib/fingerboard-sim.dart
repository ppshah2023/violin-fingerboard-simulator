import 'package:flutter/material.dart';
import 'package:tonic/tonic.dart' as tn;
import 'package:clipboard/clipboard.dart';
import 'dart:convert';

class Fingerboard extends StatefulWidget {
  @override
  _FingerboardState createState() => _FingerboardState();
}

class _FingerboardState extends State<Fingerboard> {
  var scalePattern = [];

  // it is optional to put in a list, IntervalDistance is not a list automatically placed within another list
  Padding fingerboardPeg(String noteName, [List intervalDistance]) {
    var pitch = tn.Pitch.parse(noteName);
    if (intervalDistance != null) {
      for (var i = 0; i < intervalDistance.length; i++) {
        pitch += intervalDistance[i];
      }
    }
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.001,
          horizontal: MediaQuery.of(context).size.width * 0.0001),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.05,
        height: MediaQuery.of(context).size.height * 0.05,
        child: ElevatedButton(
          clipBehavior: Clip.antiAlias,
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            minimumSize: Size(
              MediaQuery.of(context).size.width * 0.04,
              MediaQuery.of(context).size.height * 0.04,
            ),
            primary: (scalePattern.contains(pitch))
                ? Colors.deepOrange
                : Colors.blue,
          ),
          onLongPress: () {},
          onPressed: () {
            setState(
              () {
                if (!scalePattern.contains(pitch)) {
                  scalePattern.add(pitch);
                } else {
                  scalePattern.remove(pitch);
                }
              },
            );
          },
          child: Text(
            pitch.toString(),
            textScaleFactor: MediaQuery.of(context).textScaleFactor * 0.8,
          ),
        ),
      ),
    );
  }

  Padding fingerboardTape(String pitchName, String tapeName) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.001),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          fingerboardPeg(pitchName),
          fingerboardPeg(pitchName, [tn.Interval.P5]),
          fingerboardPeg(pitchName, [tn.Interval.P5, tn.Interval.P5]),
          fingerboardPeg(pitchName, [
            tn.Interval.P5,
            tn.Interval.P5,
            tn.Interval.P5,
          ]),
          SizedBox(
            child: Center(
              child: Text(tapeName),
            ),
            width: 60,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        fingerboardTape("G3", "Open"),
        fingerboardTape("Ab3", "0.5"),
        fingerboardTape("A3", "1"),
        fingerboardTape("Bb3", "1.5"),
        fingerboardTape("B3", "2"),
        fingerboardTape("C4", "3"),
        fingerboardTape("C#4", "3.5"),
        fingerboardTape("D4", "4"),
        fingerboardTape("Eb4", "4.5"),
        fingerboardTape("E4", "5"),
        fingerboardTape("F4", "5.5"),
        fingerboardTape("F#4", "6"),
        fingerboardTape("G4", "7"),
        fingerboardTape("G#4", "7.5"),
        fingerboardTape("A4", "8"),
        fingerboardTape("Bb4", "8.5"),
        PopupMenuButton(
          child: Center(child: Text('Copy, Paste, and Donate')),
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            PopupMenuItem(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    FlutterClipboard.copy(
                      scalePattern.toString(),
                    );
                  },
                  child: Text(
                    "To save your data, copy it to your clipboard and then paste it in another software",
                  ),
                ),
              ),
            ),
            PopupMenuItem(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async* {
                    var x = await FlutterClipboard.paste();
                    x = json.decode(x);
                    for (var i = 0; i < x.length; i++) {
                      var z = tn.Pitch.parse(x[i]);
                      if (!scalePattern.contains(z)) {
                        scalePattern.add(z);
                      }
                    }
                  },
                  child: Text(
                    "To open prior saved data, copy it to your clipboard and then press this button",
                  ),
                ),
              ),
            ),
            PopupMenuItem(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async* {
                    FlutterClipboard.copy(
                        "'https://www.patreon.com/pranitsh/'");
                  },
                  child: Text(
                    "Donations would be great for you and me: I always will reinvest what I get into improving, benefitting you later on when I hit it big.\nI copied my patreon link to your clipboard, you can paste it into your preferred browser.",
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
