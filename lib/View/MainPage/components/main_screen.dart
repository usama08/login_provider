import 'package:flutter/material.dart';
import 'package:lawinhandap/View/Notification/notification_screen.dart';
import '../Widgets/common_widgets.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPersmission();
    notificationServices.firebaseInit(context);
    notificationServices.isTokenRefresh();
    notificationServices.setupInteractMessage(context);
    notificationServices.getDeviceToken().then((value) {
      print("Device token ");
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Morning"),
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          Center(
            child: Container(
              alignment: Alignment.center,
              width: 320,
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.amberAccent,
                  borderRadius: BorderRadius.circular(10)),
              child: const Text(
                "Today Meeting At 6 pm",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 20,
            runSpacing: 10,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/addscreen');
                  },
                  child: myContainer(context, "Add Case")),
              myContainer(context, "Old One"),
              myContainer(context, "Meetings"),
              myContainer(context, "Note Pad"),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/imagecapture');
                  },
                  child: myContainer(context, "Add Image")),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/viewscreen');
                  },
                  child: myContainer(context, "View Case")),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/clintscreen');
                  },
                  child: myContainer(context, "Add Clint")),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/loginapis');
                  },
                  child: myContainer(context, "Apis Call ")),
              myContainer(context, ""),
              myContainer(context, ""),
            ],
          )
        ],
      ),
    );
  }
}
