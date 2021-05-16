import 'package:fingerboard_test/settings.dart';
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
        return GetMaterialApp(home: FingerBoardPage());
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
            leading: GestureDetector(
              onTap: () {
                Get.to(
                  FingerboardSettings(),
                );
              },
              child: Icon(Icons.settings),
            ),
            title: Text("The Violin Fingerboard Simulator"),
          ),
          backgroundColor: Color(0xFFe0e0e0),
          body: Simulator(),
        );
      },
    );
  }
}
