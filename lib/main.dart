import 'package:flutter/material.dart';
import 'package:r_walk_solution/threeDimensional/threeDimensional.dart';
import 'package:r_walk_solution/twoDimensional/twoDimensional.dart';
import 'oneDimension/oneDimensional.dart';

void main() {
  runApp(MainPage());
}

class MainPage extends StatefulWidget {
  // MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();

    // Initialize the Tab Controller
    controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // Dispose of the Tab Controller
    controller.dispose();
    super.dispose();
  }

  // double _formProgress = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.reorder),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Center(
          child: Text(
            'RandomWalk',
          ),
        ),
      ),
      body: TabBarView(
        // Add tabs as widgets
        children: <Widget>[
          OneDimensional(),
          TwoDimensional(),
          ThreeDimensional()
        ],
        // set the controller
        controller: controller,
      ),
      bottomNavigationBar: Material(
        // set the color of the bottom navigation bar
        color: Colors.blue,
        // set the tab bar as the child of bottom navigation bar
        child: TabBar(
          tabs: <Tab>[
            Tab(
              // set icon to the tab
              icon: Icon(Icons.first_page),
            ),
            Tab(
              icon: Icon(Icons.model_training),
            ),
            Tab(
              icon: Icon(Icons.info),
            ),
          ],
          // setup the controller
          controller: controller,
        ),
      ),
    );
  }
}
