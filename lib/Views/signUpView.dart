import 'package:crypto_payments/Views/forgotPassword.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'reusableWidgets.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key key}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {

  final _formKey = GlobalKey<FormState>();
  ReusableWidgets _reusableWidgets = new ReusableWidgets();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            backgroundColor: HexColor("#DFDFDF"),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                  child: Container(
                    child: Column(
                      children: [

                        SizedBox(height: 150,),

                        Container(
                          alignment: Alignment.center,
                          child: Image(
                            height: 100,
                            width: 300,
                            image: AssetImage("assets/crypto.PNG"),
                          ),
                        ),

                        SizedBox(height: 10,),

                        Form(
                          key: _formKey,
                          child: Column(
                            children: [

                              _reusableWidgets.textFormField("Name", false, TextInputType.name),
                              SizedBox(height: 20,),
                              _reusableWidgets.textFormField("Phone", false, TextInputType.phone),
                              SizedBox(height: 20,),
                              _reusableWidgets.textFormField("E-Mail", false, TextInputType.emailAddress),
                              SizedBox(height: 20,),
                              _reusableWidgets.textFormField("Password", true, TextInputType.name),
                              SizedBox(height: 15,),
                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ForgotPassword()),
                                    );
                                  },
                                  child: Text("Forgot Password?",
                                      style: GoogleFonts.montserrat(
                                          decoration: TextDecoration.underline,
                                          fontSize: 16,
                                          color: Colors.black87
                                      )),
                                ),
                              ),
                              SizedBox(height: 15,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 25),
                                child: SizedBox(
                                  width: double.infinity
                                  ,
                                  child: RaisedButton(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    onPressed: (){
                                      _signUp();
                                    },
                                    child: Text("Sign Up", style: GoogleFonts.montserrat(
                                        fontSize: 20,
                                        color: Colors.white
                                    )),
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20,),
                              Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: (){

                                  },
                                  child: Text("Already a Member? Sign In",
                                      style: GoogleFonts.montserrat(
                                          decoration: TextDecoration.underline,
                                          fontSize: 16,
                                          color: Colors.black87
                                      )),
                                ),
                              ),


                            ],
                          ),
                        )

                      ],
                    ),
                  ),
                ),
            ),
            ),
        ),
        );
  }

  _signUp(){

  }

}
