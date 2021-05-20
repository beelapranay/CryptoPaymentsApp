import 'package:auto_size_text/auto_size_text.dart';
import 'package:crypto_payments/Views/buyCrypto.dart';
import 'package:crypto_payments/Views/reusableWidgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WalletView extends StatefulWidget {
  const WalletView({Key key}) : super(key: key);

  @override
  _WalletViewState createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  
  ReusableWidgets _reusableWidgets = new ReusableWidgets();
  Stream walletsDataStream;

  @override
  void initState() {
    walletsDataStream = FirebaseFirestore.instance
        .collection("holdings")
        .where("uid", isEqualTo: "yY8cTIE2t9mzyrXJnAov")
        .snapshots();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _reusableWidgets.drawerWidget(context),
      backgroundColor: HexColor("#DFDFDF"),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black87,
        title: Text("My Wallet",
            style: GoogleFonts.montserrat(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold
            )
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [

            StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Holdings")
                      .where("uid", isEqualTo: FirebaseAuth.instance.currentUser.uid)
                      .snapshots(),
                  builder: (context, snapshot){

                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(Colors.black87)
                      ),);
                    }

                    else if(!snapshot.hasData || snapshot.data.docs.length == 0){
                      return Center(
                        child: AutoSizeText(
                          "You HODL no crypto!",
                          style: GoogleFonts.montserrat(),
                        ),
                      );
                    }

                    else if(snapshot.hasError){
                      return Center(
                        child: Container(
                          child: Text("Error"),
                        ),
                      );
                    }

                    return SingleChildScrollView(
                        child: Column(
                          children: [

                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ListView.separated(
                                  separatorBuilder: (BuildContext context, int index){
                                    DocumentSnapshot doc = snapshot.data.docs[index];
                                    return Divider(
                                      color: Colors.grey,
                                    );
                                  },
                                  addAutomaticKeepAlives: false,
                                  cacheExtent: 100.0,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshot.data.docs.length,
                                  itemBuilder: (BuildContext context, int index) =>
                                      _reusableWidgets.walletsData(context, snapshot.data.docs[index])
                              ),
                            ),

                          ],
                        )
                    );

                  }
              ),

              SizedBox(height: 15,),

              ElevatedButton(
                onPressed: (){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => BuyCrypto()),
                  );
                },
                child: Text("Buy Crypto", style: GoogleFonts.montserrat(
                    fontSize: 20,
                    color: HexColor("#DFDFDF")
                )),
                style: ElevatedButton.styleFrom(
                  primary: Colors.black87
                ),
              )

          ],
        ),
      ),
    );
  }
}
