import 'package:crypto_payments/Views/reusableWidgets.dart';
import 'package:crypto_payments/firebaseFunctions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class TransferCrypto extends StatefulWidget {
  const TransferCrypto({Key key}) : super(key: key);

  @override
  _TransferCryptoState createState() => _TransferCryptoState();
}

class _TransferCryptoState extends State<TransferCrypto> {

  ReusableWidgets _reusableWidgets = new ReusableWidgets();
  FirebaseFunctions _firebaseFunctions = new FirebaseFunctions();
  TextEditingController _walletTextEditingController = new TextEditingController();
  TextEditingController _quantityTextEditingController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#DFDFDF"),

      drawer: _reusableWidgets.drawerWidget(context),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black87,
        title: Text("Transfer",
            style: GoogleFonts.montserrat(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold
            )
        ),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 40),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                  controller: _walletTextEditingController,
                  keyboardType: TextInputType.emailAddress,
                  style: GoogleFonts.montserrat(
                      fontSize: 18
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "This field can't be empty.";
                    }
                    if (value.length < 28) {
                      return "Please enter a valid wallet address!";
                    }
                    return null;
                  },
                  cursorColor: Colors.black12,
                  cursorWidth: 1,
                  obscureText: false,
                  decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black87, width: 2.0),
                      ),
                      border: const OutlineInputBorder(),
                      labelText: "Wallet Address",
                      errorStyle: GoogleFonts.montserrat(),
                      labelStyle: GoogleFonts.montserrat(
                          color: Colors.black.withOpacity(0.6)
                      )
                  ),
                ),
              SizedBox(height: 15,),
              TextFormField(
                controller: _quantityTextEditingController,
                keyboardType: TextInputType.number,
                style: GoogleFonts.montserrat(
                    fontSize: 18
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return "This field can't be empty.";
                  }
                  if (value.length < 1) {
                    return "Please enter a valid quantity!";
                  }
                  return null;
                },
                cursorColor: Colors.black12,
                cursorWidth: 1,
                obscureText: false,
                decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black87, width: 2.0),
                    ),
                    border: const OutlineInputBorder(),
                    labelText: "Quantity",
                    errorStyle: GoogleFonts.montserrat(),
                    labelStyle: GoogleFonts.montserrat(
                        color: Colors.black.withOpacity(0.6)
                    )
                ),
              ),
              SizedBox(height: 15,),

              ElevatedButton(
                onPressed: (){
                  String walletAddress = _walletTextEditingController.text.toString();
                  String quantity = _quantityTextEditingController.text.toString();
                  _transferCrypto(walletAddress, quantity);
                },
                child: Text("Transfer BTC", style: GoogleFonts.montserrat(
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
      ),

    );
  }

  _transferCrypto(String walletAddress, String quantity) async{
    if(_formKey.currentState.validate()){
      print(walletAddress);
      await _firebaseFunctions.transferCrypto(walletAddress, quantity);
    }
  }

}
