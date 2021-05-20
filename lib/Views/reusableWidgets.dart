import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class ReusableWidgets{

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
          listTileWidget(Icon(Icons.transfer_within_a_station_rounded), context, "/transferCrypto", "Transfers"),

          SizedBox(height: 20,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [HexColor("#4CA1AF"), HexColor("#C4E0E5")]
                ),
                borderRadius: BorderRadius.circular(20)
              ),
              child: Column(
                children: [

                  Text("Breaking", style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  )),
                  SizedBox(height: 8,),
                  Text("Fueling the volatility is Tesla CEO Musk himself, "
                      "who surprised crypto advocates last week with an "
                      "announcement that the company would no longer accept "
                      "Bitcoin as payment. The mood music grew darker over the "
                      "weekend, with Bitcoin dropping about 15% as Musk "
                      "doubled-down on his criticism of the cryptocurrency’s "
                      "environmental load.", style: GoogleFonts.montserrat())

                ],
              ),
            ),
          )

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
    String btc = documentSnapshot.get("btc");
    String ada = documentSnapshot.get("ada");
    String xrp = documentSnapshot.get("xrp");
    String uni = documentSnapshot.get("uni");
    String dot = documentSnapshot.get("dot");
    String inr = documentSnapshot.get("inr");

    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text(
                      "Balance",
                    style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    )
                  ),

                  Text(
                    "₹ $inr",
                      style: GoogleFonts.montserrat(
                          fontSize: 18
                      )
                  )

                ],
              ),
            ),

            Divider(
              thickness: 1.5,
              height: 2,
              color: Colors.grey,
            ),

            listTile(eth, "eth.png"),
            listTile(btc, "btc.png"),
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

}