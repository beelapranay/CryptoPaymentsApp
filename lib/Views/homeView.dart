import 'package:crypto_payments/Views/reusableWidgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  ReusableWidgets _reusableWidgets = new ReusableWidgets();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#DFDFDF"),
      drawer: _reusableWidgets.drawerWidget(context),
          appBar: AppBar(
            actions: [

              IconButton(onPressed: (){
                FirebaseAuth.instance.signOut();
              }, icon: Icon(Icons.logout))

            ],
            centerTitle: true,
            backgroundColor: Colors.black87,
            title: Text("Crypt (ic)",
                style: GoogleFonts.montserrat(
                    fontSize: 22,
                    color: Colors.white,
                  fontWeight: FontWeight.bold
                )
            ),
          ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [

              _reusableWidgets.listTileWidgetCrypto("\$ 39937 ", "BTC/USD", "btc.png"),
              _reusableWidgets.listTileWidgetCrypto("\$ 2650 ", "ETH/USD", "eth.png"),
              _reusableWidgets.listTileWidgetCrypto("\$ 1.641 ", "ADA/USD", "ada.png"),
              _reusableWidgets.listTileWidgetCrypto("\$ 365.8 ", "BNB/USD", "bnb.png"),
              _reusableWidgets.listTileWidgetCrypto("\$ 0.368 ", "DOGE/USD", "doge.png"),
              _reusableWidgets.listTileWidgetCrypto("\$ 0.0000106 ", "SHIB/USD", "shiba.png"),
              _reusableWidgets.listTileWidgetCrypto("\$ 1.925 ", "MATIC/USD", "matic.png"),
              _reusableWidgets.listTileWidgetCrypto("\$ 27.76 ", "DOT/USD", "dot.png"),
              _reusableWidgets.listTileWidgetCrypto("\$ 1.170 ", "XRP/USD", "xrp.png"),
              _reusableWidgets.listTileWidgetCrypto("\$ 0.004 ", "BTT/USD", "btt.png"),
              _reusableWidgets.listTileWidgetCrypto("\$ 25.12 ", "UNI/USD", "uni.png"),
              _reusableWidgets.listTileWidgetCrypto("\$ 0.115 ", "VET/USD", "vet.png"),

            ],
          ),
        ),
      ),
        );
  }

}
