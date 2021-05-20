import 'package:auto_size_text/auto_size_text.dart';
import 'package:crypto_payments/Views/reusableWidgets.dart';
import 'package:crypto_payments/firebaseFunctions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'homeView.dart';

class BuyCrypto extends StatefulWidget {
  const BuyCrypto({Key key}) : super(key: key);

  @override
  _BuyCryptoState createState() => _BuyCryptoState();
}

class _BuyCryptoState extends State<BuyCrypto> {

  ListTile listTile(String name, String image){
    return ListTile(
      leading: Image(image: AssetImage('assets/$image'),height: 35,width: 35,),
      title: Text(name, style: GoogleFonts.montserrat(),),
    );
  }
  
  ReusableWidgets _reusableWidgets = new ReusableWidgets();
  FirebaseFunctions _firebaseFunctions = new FirebaseFunctions();
  bool onPressed = false;
  String activeCrypto;
  final _formKey = GlobalKey<FormState>();
  List<String> availableCryptos = [
    'ETH', 'BTC', 'ADA', 'XRP', 'UNI'
  ];
  TextEditingController quantityController = new TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black87,
        title: Text("Market",
            style: GoogleFonts.montserrat(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold
            )
        ),
      ),
      drawer: _reusableWidgets.drawerWidget(context),
      backgroundColor: HexColor("DFDFDF"),
      body: onPressed ?

          SingleChildScrollView(
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    child: IconButton(
                        onPressed: (){
                          setState(() {
                            onPressed = false;
                          });
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomeView()),
                          );
                        },
                        icon: Icon(Icons.close, size: 30,)
                    ),
                    alignment: Alignment.centerRight,
                  ),
                ),

                Container(
                    height: 500,
                    width: 500,
                  child: LottieBuilder.asset("assets/true.json")
                ),

                Text("Your order has been placed!",
                  style: GoogleFonts.montserrat(
                    fontSize: 20
                  ))

              ],
            ),
          )

      :

      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text("What would you like to invest in today?",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(fontSize: 20),
              ),

              SizedBox(height: 10,),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButton(
                  icon: Icon(Icons.arrow_drop_down, color: Colors.black,),
                  style: GoogleFonts.montserrat(color: Colors.black),
                  hint: AutoSizeText("Select Crypto", style: GoogleFonts.montserrat(
                    fontSize: 18
                  ),),
                  isExpanded: true,
                  elevation: 24,
                  value: activeCrypto,
                  items: availableCryptos.map((valueItem) {
                    return DropdownMenuItem(
                      child: Text(valueItem),
                      value: valueItem,
                    );
                  }).toList(),
                  onChanged: (dynamic value) {
                    setState(() {
                      activeCrypto = value;
                    });
                  },
                ),
              ),

              SizedBox(height: 10,),

          Form(
            key: _formKey,
            child: TextFormField(
              controller: quantityController,
              validator: (value) {
                if (value.isEmpty) {
                  return "This field can't be empty.";
                }
                if (value.length < 1) {
                  return "Please enter a valid value!";
                }
                return null;
              },
              keyboardType: TextInputType.number,
              style: GoogleFonts.montserrat(
                  fontSize: 18
              ),
              cursorColor: Colors.black12,
              cursorWidth: 1,
              obscureText: false,
              decoration: InputDecoration(
                errorStyle: GoogleFonts.montserrat(),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black87, width: 2.0),
                  ),
                  border: const OutlineInputBorder(),
                  labelText: "Quantity",
                  labelStyle: GoogleFonts.montserrat(
                      color: Colors.black.withOpacity(0.6)
                  )
              ),
            ),
          ),

              SizedBox(height: 15,),

              activeCrypto != null ?
                  Text(
                      "Buying - $activeCrypto",
                       style: GoogleFonts.montserrat(fontSize: 18),
                  )
                  : Container(height: 0,),

              SizedBox(height: 15,),

              ElevatedButton(
                onPressed: (){
                  updateHoldings(quantityController.text.toString(), activeCrypto);
                },
                child: Text("Place Order", style: GoogleFonts.montserrat(
                    fontSize: 18,
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

  updateHoldings(String quantity, String crypto) async{



    if(_formKey.currentState.validate()){
      await _firebaseFunctions.updateHoldings(quantity, crypto.toLowerCase());
      setState(() {
        onPressed = true;
      });
    }
  }

}
