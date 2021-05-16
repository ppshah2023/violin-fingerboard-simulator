import 'package:fingerboard_test/settings.dart';
import 'package:fingerboard_test/sheet_music.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:sizer/sizer.dart';
import 'package:get_storage/get_storage.dart';
import 'package:fingerboard_test/fingerboardSim.dart';

void main() async {
  runApp(MyApp());
  await GetStorage.init(); //get storage initialization
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          home: FingerBoardPage(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

class FingerBoardPage extends StatefulWidget {
  @override
  _FingerBoardPageState createState() => _FingerBoardPageState();
}

class _FingerBoardPageState extends State<FingerBoardPage> {
  final datacount = GetStorage(); // instance of getStorage class

  @override
  void initState() {
    super.initState();
    datacount.write("first", "");
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              gestureIcon(Icons.settings, () {
                Get.to(FingerboardSettings());
              }),
              gestureIcon(Icons.refresh, () {
                setState(() {});
              }),
              gestureIcon(Icons.help, () {
                Get.snackbar(
                    "Hello\nDouble tapping erases everything\nTapping saves the pitch tapped and can affect other frets positions with the exact same pitch.\nRefreshing shows any changes that have yet to appear.\nRefreshes can occur also by changing the screen size.\nSwipe this up to remove this message.",
                    "Thanks for reading.",
                    duration: Duration(seconds: 30));
              }),
              gestureIcon(Icons.music_note, () {
                Get.to(Notator());
              }),
            ],
            title: Text("The Violin Fingerboard Simulator"),
          ),
          backgroundColor: Color(0xFFe0e0e0),
          body: Column(
            children: [
              Expanded(child: Simulator(), flex: 1),
              Expanded(child: Notator(), flex: 4),
            ],
          ),
        );
      },
    );
  }

  Padding gestureIcon(IconData icon, Function x) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: x,
        child: Icon(icon),
      ),
    );
  }
}
