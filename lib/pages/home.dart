import 'package:flutter/material.dart';
import 'package:tourism/pages/location_page.dart';
// import 'package:tourism/pages/map.dart';
import 'package:tourism/pages/status.dart';
import 'package:tourism/pallete.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
List<Step> stepList() => [
		const Step(title: Text('Kochi'), content: Center(child: Text('9.00 AM'),)),
		const Step(title: Text('Munnar'), content: Center(child: Text('1.00 PM'),)),
		const Step(title: Text('Vagamon'), content: Center(child: Text('9.00 PM'),))
];
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        home: DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Pallete.green,
              title: const Text("Tourism"),
            ),
            bottomNavigationBar: menu(),
            body:  const TabBarView(
              children: [
               
		           StatusPage(),
                LocationPage(),
         
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
        text: "Map",
        icon: Icon(Icons.location_pin),
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