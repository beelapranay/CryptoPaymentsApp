import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.black87,
            title: Text("Home Page",
                style: GoogleFonts.montserrat(
                    fontSize: 20,
                    color: Colors.white
                )
            ),
          ),
        );
  }
}
