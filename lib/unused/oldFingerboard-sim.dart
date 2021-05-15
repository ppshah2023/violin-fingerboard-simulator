import 'package:flutter/material.dart';
import 'package:tonic/tonic.dart' as tn;
import 'package:clipboard/clipboard.dart';
import 'package:get/get_rx/get_rx.dart';

class Fingerboard extends StatefulWidget {
  @override
  _FingerboardState createState() => _FingerboardState();
}

class _FingerboardState extends State<Fingerboard> {
  var scalePatternOrange = <tn.Pitch>[].obs;
  var scalePatternBlue = <tn.Pitch>[].obs;

  Color determineColor(pitch) {
    if (scalePatternOrange.contains(pitch) &&
        !scalePatternBlue.contains(pitch)) {
      return Colors.deepOrange;
    } else if (scalePatternBlue.contains(pitch) &&
        !scalePatternOrange.contains(pitch)) {
      return Colors.green;
    } else if (scalePatternOrange.contains(pitch) &&
        scalePatternBlue.contains(pitch)) {
      return Colors.purple;
    } else {
      return Colors.blue;
    }
  }

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
            primary: determineColor(pitch),
          ),
          onLongPress: () {
            setState(
              () {
                if (!scalePatternBlue.contains(pitch)) {
                  scalePatternBlue.add(pitch);
                } else {
                  scalePatternBlue.remove(pitch);
                }
              },
            );
          },
          onPressed: () {
            setState(
              () {
                if (!scalePatternOrange.contains(pitch)) {
                  scalePatternOrange.add(pitch);
                } else {
                  scalePatternOrange.remove(pitch);
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

  Column fingerboardBoard() {
    return Column(
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      panEnabled: false, // Set it to false to prevent panning.
      boundaryMargin: EdgeInsets.all(80),
      minScale: 0.5,
      maxScale: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.1,
              height: MediaQuery.of(context).size.height * 0.05,
              child: PopupMenuButton(
                child: Center(child: Text('Copy, Paste, and Donate')),
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  PopupMenuItem(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          FlutterClipboard.copy(
                            scalePatternOrange.toString(),
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
            ),
          ),
        ],
      ),
    );
  }
}
