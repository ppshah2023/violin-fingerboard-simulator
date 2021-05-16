import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';

class FingerboardSettings extends StatefulWidget {
  @override
  _FingerboardSettingsState createState() => _FingerboardSettingsState();
}

class _FingerboardSettingsState extends State<FingerboardSettings> {
  final datacount = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings for the Violin Fingerboard Simulator"),
      ),
      body: Center(
        child: ListView(
          children: [
            preferencer(
              "String 1",
              'Write the name of note and the octave as an int. Guitar starts at E2. Violin starts at G3.',
            ),
            preferencer(
              "String 2",
              'Write the name of note and the octave as an int. Guitar starts at E2. Violin starts at G3.',
            ),
            preferencer(
              "String 3",
              'Write the name of note and the octave as an int. Guitar starts at E2. Violin starts at G3.',
            ),
            preferencer(
              "String 4",
              'Write the name of note and the octave as an int. Guitar starts at E2. Violin starts at G3.',
            ),
            preferencer(
              "String 5",
              'Write the name of note and the octave as an int. Guitar starts at E2. Violin starts at G3.',
            ),
            preferencer(
              "String 6",
              'Write the name of note and the octave as an int. Guitar starts at E2. Violin starts at G3.',
            ),
            preferencer(
              "String 7",
              'Write the name of note and the octave as an int. Guitar starts at E2. Violin starts at G3.',
            ),
            preferencer(
              "String 8",
              'Write the name of note and the octave as an int. Guitar starts at E2. Violin starts at G3.',
            ),
            preferencer(
              "String 9",
              'Write the name of note and the octave as an int. Guitar starts at E2. Violin starts at G3.',
            ),
            preferencer(
              "String 10",
              'Write the name of note and the octave as an int. Guitar starts at E2. Violin starts at G3.',
            ),
            preferencer(
              "NumberOfFrets",
              'Write a number. Default is 20.',
            ),
          ],
        ),
      ),
    );
  }

  Widget preferencer(String stringName, String helperText) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        decoration:
            InputDecoration(labelText: stringName, helperText: helperText),
        onFieldSubmitted: (value) {
          datacount.write(stringName, '${value.toString()}');
          String x = datacount.read(stringName);
          Get.snackbar("The form has been saved", "The value saved was $x");
        },
      ),
    );
  }
}
