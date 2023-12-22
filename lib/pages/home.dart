import 'package:flutter/material.dart';
import 'package:tourism/pages/location_page.dart';
import 'package:tourism/pages/map.dart';
import 'package:tourism/pages/status.dart';
import 'package:tourism/pallete.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
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
