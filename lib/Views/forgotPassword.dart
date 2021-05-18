import 'package:crypto_payments/Views/reusableWidgets.dart';
import 'package:crypto_payments/firebaseFunctions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final _formKey = GlobalKey<FormState>();
  FirebaseFunctions _firebaseFunctions = new FirebaseFunctions();
  TextEditingController _emailTextEditingController = new TextEditingController();
  ReusableWidgets _reusableWidgets = new ReusableWidgets();
  bool onPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#DFDFDF"),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () async{
                onPressed = false;
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)
          ),
          backgroundColor: Colors.black87,
          title: Text("Forgot Password",
            style: GoogleFonts.montserrat(
              fontSize: 20,
              color: Colors.white
            )
          ),
        ),
        body: onPressed ?

              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Container(
                      height: 200,
                      width: 200,
                      child: LottieBuilder.asset("assets/mail.json"),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        "Please check your mail for the password reset link! 😃",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    )

                  ],
                ),
              )
            :
        Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                TextFormField(
                  controller: _emailTextEditingController,
                  keyboardType: TextInputType.emailAddress,
                  style: GoogleFonts.montserrat(
                      fontSize: 18
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "This field can't be empty!";
                    }
                    if (value.length < 3) {
                      return "Please enter a E-Mail address!";
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
                      labelText: "E-Mail",
                      errorStyle: GoogleFonts.montserrat(),
                      labelStyle: GoogleFonts.montserrat(
                          color: Colors.black.withOpacity(0.6)
                      )
                  ),
                ),

                SizedBox(height: 20,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: SizedBox(
                    width: double.infinity
                    ,
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      onPressed: (){
                        String _email = _emailTextEditingController.text.toString();
                        // ignore: unnecessary_statements
                        onPressed ? null : _forgotPassword(_email);
                      },
                      child: Text("Reset Password", style: GoogleFonts.montserrat(
                          fontSize: 20,
                          color: Colors.white
                      )),
                      color: Colors.black87,
                    ),
                  ),
                ),

              ],
            ),
          ),
        )
      );
  }

  _forgotPassword(email) async {
    if(_formKey.currentState.validate()){
      setState(() {
        onPressed = true;
      });
      await _firebaseFunctions.sendResetMail(email);
    }
  }

}
