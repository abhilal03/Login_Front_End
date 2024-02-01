import 'package:flutter/material.dart';
import 'package:tourism/pages/location_page.dart';
import 'package:tourism/pages/map.dart';
import 'package:tourism/pages/status.dart';
import 'package:tourism/pallete.dart';

import 'popup_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoggedIn = false;

  void _login() {
    setState(() {
      isLoggedIn = true;
    });

    _showPopup();
  }

  void _showPopup() {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return const PopupContent();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _login();
            },
            foregroundColor: Pallete.whiteColor,
            backgroundColor: Pallete.green,
            shape: const CircleBorder(),
            child: const Icon(Icons.schedule_send),
          ),
          appBar: AppBar(
            backgroundColor: Pallete.green,
            title: const Text("Tourism"),
            titleTextStyle:
                const TextStyle(color: Pallete.whiteColor, fontSize: 20),
          ),
          bottomNavigationBar: menu(),
          body: const TabBarView(
            children: [
              StatusPage(),
              LocationPage(),
              MapPage(),
              Icon(Icons.settings),
            ],
          ),
        ),
      ),
    );
  }

  Widget menu() {
    return Container(
      color: Pallete.green,
      child: const TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: Color.fromARGB(179, 182, 179, 179),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(5.0),
        indicatorColor: Pallete.whiteColor,
        tabs: [
          Tab(
            text: "Schedule",
            icon: Icon(Icons.schedule_outlined),
          ),
          Tab(
            text: "Location",
            icon: Icon(Icons.location_pin),
          ),
          Tab(
            text: "Map",
            icon: Icon(Icons.language_sharp),
          ),
          Tab(
            text: "Setting",
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
