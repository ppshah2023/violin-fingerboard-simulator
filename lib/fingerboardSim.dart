import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tonic/tonic.dart' as tn;
import 'package:get/state_manager.dart';
import 'dart:math';

class Simulator extends StatefulWidget {
  @override
  _SimulatorState createState() => _SimulatorState();
}

class _SimulatorState extends State<Simulator> {
  final datacount = GetStorage();
  tn.FrettedInstrument instrument;

  @override
  void initState() {
    super.initState();
    datacount.write("String 1", 'G3');
    datacount.write("String 2", 'D4');
    datacount.write("String 3", 'A4');
    datacount.write("String 4", 'E5');
    datacount.write("NumberOfFrets", '20');
    List pitches = [
      datacount.read("String 1"),
      datacount.read("String 2"),
      datacount.read("String 3"),
      datacount.read("String 4"),
      datacount.read("String 5"),
      datacount.read("String 6"),
      datacount.read("String 7"),
      datacount.read("String 8"),
      datacount.read("String 9"),
      datacount.read("String 10"),
    ];
    pitches.removeWhere(
      (element) {
        if (element == null) {
          return true;
        } else {
          return false;
        }
      },
    );
    List<tn.Pitch> x = [];
    for (int i = 0; i < pitches.length; i++) {
      x.add(tn.Pitch.parse(pitches[i]));
    }
    instrument = tn.FrettedInstrument(
      name: datacount.read("NumberOfFrets"),
      stringPitches: x,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 400,
        height: 1200,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xffcacaca),
              Color(0xfff0f0f0),
            ], transform: GradientRotation(0.75 * pi / 4)),
            boxShadow: [
              BoxShadow(
                  offset: Offset(10, 10),
                  color: Color(0xffbebebe),
                  blurRadius: 20),
              BoxShadow(
                  offset: Offset(-10, -10),
                  color: Color(0xffffffff),
                  blurRadius: 20)
            ],
          ),
          child: GridView.count(
            crossAxisCount: 4,
            children: List.generate(
              instrument.stringPitches.length * int.parse(instrument.name),
              (int index) {
                int string = (index % instrument.stringPitches.length);
                int fretPosition =
                    (index / instrument.stringPitches.length).floor();
                tn.Pitch pitch = instrument.pitchAt(
                  stringIndex: string,
                  fretNumber: fretPosition,
                );
                String interval = "Out of range";
                if (fretPosition < 13 && fretPosition > 0) {
                  interval =
                      (pitch - instrument.stringPitches[string]).toString();
                } else if (fretPosition == 0) {
                  interval = "0";
                }
                // else if (fretPosition < 26 && fretPosition > 13) {
                //   String newPitch = (pitch - tn.Interval.P8).toString();
                //   interval = "P8" +
                //       (tn.Pitch.parse(newPitch) -
                //               instrument.stringPitches[string])
                //           .toString();
                // }
                Gradient color(int i) {
                  if ((i % 2) == 0) {
                    return LinearGradient(
                      colors: [
                        Color(0xffcacaca),
                        Color(0xffe6e7ee),
                      ],
                      transform: GradientRotation(0.75 * pi / 4),
                    );
                  } else {
                    return LinearGradient(
                      colors: [
                        Color(0xff5a00d9),
                        Color(0xff7a00ff),
                      ],
                      transform: GradientRotation(0.75 * pi / 4),
                    );
                  }
                }

                var taps = 0.obs;
                if (datacount
                    .read("first")
                    .toString()
                    .contains(pitch.toString())) {
                  taps += 1;
                }
                return Padding(
                  padding: EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onTap: () {
                      taps += 1;
                      String x = datacount.read("first");
                      String thePitch = pitch.toString();
                      x += " " + thePitch;
                      datacount.write("first", x);
                      print(datacount.read("first"));
                    },
                    onDoubleTap: () {
                      datacount.remove("first");
                      datacount.write("first", "");
                    },
                    child: Obx(
                      () => Tooltip(
                        message:
                            "${pitch.toString()}, taps: ${taps.toString()}, position: ${fretPosition.toString()}, interval: ${interval.toString()}",
                        child: Container(
                          child: Center(
                            child: Text(pitch
                                .toString()
                                .replaceFirst(
                                    RegExp("[1,2,3,4,5,6,7,8,9,0]"), "")
                                .toString()),
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: color(taps.toInt()),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(10, 10),
                                  color: Color(0xffbebebe),
                                  blurRadius: 20),
                              BoxShadow(
                                  offset: Offset(-10, -10),
                                  color: Color(0xffffffff),
                                  blurRadius: 20)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
