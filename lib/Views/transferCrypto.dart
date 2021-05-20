import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_payments/Views/reusableWidgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class CryptoPayments extends StatefulWidget {
  const CryptoPayments({Key key}) : super(key: key);

  @override
  _CryptoPaymentsState createState() => _CryptoPaymentsState();
}

class _CryptoPaymentsState extends State<CryptoPayments> {

  Stream pendingStream, paidStream;
  ReusableWidgets _reusableWidgets = new ReusableWidgets();

  @override
  void initState() {
    pendingStream = FirebaseFirestore.instance
        .collection("Holdings")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("transfers")
        .where("status", isEqualTo: "Pending")
        .orderBy("amount", descending: true)
        .snapshots();

    paidStream = FirebaseFirestore.instance
        .collection("Holdings")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("transfers")
        .where("status", isEqualTo: "Paid")
        .orderBy("amount", descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: HexColor("#DFDFDF"),
          drawer: _reusableWidgets.drawerWidget(context),
          appBar: AppBar(
            bottom: TabBar(
              unselectedLabelColor: Colors.white,
              tabs: [

                Tab(
                  child: AutoSizeText("Pending", style: GoogleFonts.montserrat(color: Colors.white),),
                ),

                Tab(
                  child: AutoSizeText("Paid", style: GoogleFonts.montserrat(color: Colors.white),),
                )

              ],
            ),
            backgroundColor: Colors.black87,
            centerTitle: true,
            title: Text(
                "Payments",
                style: GoogleFonts.montserrat(
                    fontSize: 22,
                    fontWeight: FontWeight.bold)
            ),
          ),
          body: TabBarView(
            children: [

              Scaffold(
                backgroundColor: HexColor("DFDFDF"),
                body: StreamBuilder(
                    stream: pendingStream,
                    builder: (context, snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(
                          child: CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(Colors.black87)
                          ),
                        );
                      }

                      else if(!snapshot.hasData || snapshot.data.docs.length == 0){
                        return Center(
                          child: AutoSizeText(
                            "You have paid all the bills!",
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

                      return

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
                                        _reusableWidgets.paymentsData(context, snapshot.data.docs[index])
                                )

                              );}
                ),
              ),
              ////\\\\
              Scaffold(
                backgroundColor: HexColor("#DFDFDF"),
                body: StreamBuilder(
                    stream: paidStream,
                    builder: (context, snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(
                          child: CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(Colors.black87)
                          ),
                        );
                      }

                      else if(!snapshot.hasData || snapshot.data.docs.length == 0){
                        return Center(
                          child: AutoSizeText(
                            "You have not paid any bills!",
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

                      return

                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ListView.separated(
                                    separatorBuilder: (BuildContext context, int index){
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
                                        _reusableWidgets.paymentsData(context, snapshot.data.docs[index])
                                ),
                              );

                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
