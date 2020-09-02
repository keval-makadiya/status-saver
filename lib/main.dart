import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:status_save/constants.dart';
import 'package:status_save/screens/ImageScreen.dart';
import 'package:status_save/screens/SavedScreen.dart';
import 'package:status_save/screens/VideoScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        accentColor: Colors.amber[300],
        primaryColor: Colors.pink[900],
        primaryTextTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
              ),
        ),
        textTheme: GoogleFonts.sourceSansProTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(appName),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.image), text: imgTabName),
                Tab(icon: Icon(Icons.videocam), text: videoTabName),
                Tab(icon: Icon(Icons.save_alt), text: savedTabName),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ImageScreen(),
              VideoScreen(),
              SavedScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
