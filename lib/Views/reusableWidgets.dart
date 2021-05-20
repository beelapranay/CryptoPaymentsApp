import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class ReusableWidgets{

  double prevPaymentBTC, afterPaymentBTC, finalAmount;

  TextFormField textFormField(String labelText,
      bool isObscureText,
      TextInputType textInputType){
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return "This field can't be empty.";
        }
        if (value.length < 10) {
          return "Your password is too short!";
        }
        return null;
      },
      keyboardType: textInputType,
      style: GoogleFonts.montserrat(
          fontSize: 18
      ),
      cursorColor: Colors.black12,
      cursorWidth: 1,
      obscureText: isObscureText,
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black87, width: 2.0),
          ),
          border: const OutlineInputBorder(),
          labelText: labelText,
          labelStyle: GoogleFonts.montserrat(
              color: Colors.black.withOpacity(0.6)
          )
      ),
    );
  }

  ElevatedButton elevatedButton(Function function, String elevatedButtonText){
    return ElevatedButton(
        onPressed: function,
        child: Text(elevatedButtonText, style: GoogleFonts.montserrat(
          fontSize: 20,
          color: Colors.black87
        )),
    );
  }

  ListTile listTileWidget(Icon icon, BuildContext context, String routeName, String title) {
    return ListTile(
      onTap: (){
        Navigator.pushReplacementNamed(context, routeName);
      },
      leading: icon,
      title: AutoSizeText(
        title,
        style: GoogleFonts.montserrat(),
        maxLines: 1,
        minFontSize: 18,
      ),
    );
  }

  Drawer drawerWidget(BuildContext context){

    return Drawer(
      child: Column(
        children: [
          SizedBox(height: 50,),
          listTileWidget(Icon(Icons.home), context, "/home", "Home"),
          listTileWidget(Icon(Icons.monetization_on_outlined), context, "/market", "Market"),
          listTileWidget(Icon(Icons.account_circle_outlined), context, "/profileView", "Profile"),
          listTileWidget(Icon(Icons.account_balance_wallet_rounded), context, "/walletView", "Wallet"),
          listTileWidget(Icon(Icons.transfer_within_a_station_rounded), context, "/cryptoPayments", "Payments")
        ],
      ),
    );
  }

  ListTile listTile(String name, String image){
    return ListTile(
      leading: Image(image: AssetImage('assets/$image'),height: 35,width: 35,),
      title: Text(name, style: GoogleFonts.montserrat(),),
    );
  }

  Widget walletsData(BuildContext context, DocumentSnapshot documentSnapshot){

    String eth = documentSnapshot.get("eth");
    double btc1 = double.parse(documentSnapshot.get("btc"));
    double btc = double.parse(btc1.toStringAsFixed(3));
    String ada = documentSnapshot.get("ada");
    String xrp = documentSnapshot.get("xrp");
    String uni = documentSnapshot.get("uni");
    String dot = documentSnapshot.get("dot");

    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          children: [

            listTile(eth, "eth.png"),
            listTile(btc.toString(), "btc.png"),
            listTile(ada, "ada.png"),
            listTile(xrp, "xrp.png"),
            listTile(uni, "uni.png"),
            listTile(dot, "dot.png")

          ],
        )
    );
  }

  Column listTileWidgetCrypto(String title, String subTitle, String image){
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white, width: 2.0)
          ),
          child: ListTile(
            leading: Image(image: AssetImage("assets/$image"),height: 35, width: 35,),
            title: Text(title, style: GoogleFonts.montserrat()),
            subtitle: Text(subTitle, style: GoogleFonts.montserrat(),),
          ),
        ),
        SizedBox(height: 8,)
      ],
    );
  }

  Widget paymentsData(BuildContext context, DocumentSnapshot documentSnapshot){

    AutoSizeText _autoSizeTextBold(String text){
      return AutoSizeText(
        text,
        style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 20
        ),
      );
    }

    String image = documentSnapshot.get("image");
    String status = documentSnapshot.get("status");
    double amount = documentSnapshot.get("amount");

    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          children: [

            Align(
                alignment: Alignment.center,
                child: Image(
                  height: 100,
                  width: 100,
                  image: NetworkImage(image),
                )
            ),

            SizedBox(height: 8,),

            AutoSizeText(
                "$amount BTC",
                style: GoogleFonts.montserrat(
                    color: Colors.green,
                    fontSize: 16
                )
            ),

            SizedBox(height: 8,),

            AutoSizeText(
                "Status - $status",
                style: GoogleFonts.montserrat(
                    color: status == "Pending" ? Colors.deepOrangeAccent : Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                )
            ),

            status != "Pending" ? Container(height: 0,)
                : OutlineButton(
                highlightedBorderColor: Colors.black87,
                borderSide: BorderSide(color: Colors.black87),
                child: Text("Pay with BTC",
                    style: GoogleFonts.montserrat()
                ),
                onPressed: () async {
                  if (status == "Pending") {

                    await FirebaseFirestore.instance.collection('Holdings')
                        .doc(FirebaseAuth.instance.currentUser.uid)
                    // ignore: non_constant_identifier_names
                        .get().then((DocumentSnapshot) =>
                    {
                      prevPaymentBTC = double.parse(DocumentSnapshot.get("btc")),
                    }
                    );

                    finalAmount = prevPaymentBTC - amount;

                    prevPaymentBTC < amount ? null :

                    await FirebaseFirestore.instance
                        .collection("Holdings")
                        .doc(FirebaseAuth.instance.currentUser.uid)
                        .collection("transfers")
                        .doc(documentSnapshot.id)
                        .update({
                      "status": "Paid",
                    });

                    await FirebaseFirestore.instance
                        .collection("Holdings")
                        .doc(FirebaseAuth.instance.currentUser.uid)
                        .update({
                      "btc": finalAmount.toString(),
                    });
                  }
                }
              ),

          ],
        )
    );

  }

}