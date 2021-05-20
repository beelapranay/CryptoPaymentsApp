import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'reusableWidgets.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  
  String _imageUrl = "https://sm.mashable.com/mashable_in/feature/i/is-baby-yo/is-baby-yoda-turning-to-the-dark-side-we-investigated_v7t2.jpg";
  String _name = FirebaseAuth.instance.currentUser.displayName;
  String _email = FirebaseAuth.instance.currentUser.email;
  ReusableWidgets _reusableWidgets = new ReusableWidgets();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#DFDFDF"),
      drawer: _reusableWidgets.drawerWidget(context),
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("Profile", style: GoogleFonts.montserrat(
            color: HexColor("#DFDFDF"),
            fontSize: 22, 
            fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          children: [

            SizedBox(height: 50,),

            CircleAvatar(
              radius: 64,
              backgroundColor: Colors.black87,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  _imageUrl
                ),
                radius: 60,
              ),
            ),

            SizedBox(height: 15,),

            Text(
              _name,
              style: GoogleFonts.montserrat(
                fontSize: 18
              ),
            ),

            SizedBox(height: 15,),

            AutoSizeText(
              _email,
              style: GoogleFonts.montserrat(),
              minFontSize: 17,
              maxLines: 2,
            ),
            
            SizedBox(height: 15,),
            
            AutoSizeText("Your BTC wallet address is:", style: GoogleFonts.montserrat(),),
            SizedBox(height: 5,),
            Container
              (child: AutoSizeText(
              FirebaseAuth.instance.currentUser.uid, style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)
              ,),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white)
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: AutoSizeText(
                  "The above mentioned wallet address can "
                      "be used to send and receive BTC.",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(

                ),
              ),
            )


          ],
        ),
      ),
    );
  }
}
