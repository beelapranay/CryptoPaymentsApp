import 'package:crypto_payments/Views/signUpView.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import '../firebaseFunctions.dart';
import 'forgotPassword.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key key}) : super(key: key);

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {

  final _formKey = GlobalKey<FormState>();
  FirebaseFunctions _firebaseFunctions = new FirebaseFunctions();
  bool _isLoading = false;
  TextEditingController _emailTextEditingController = new TextEditingController();
  TextEditingController _passwordTextEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: HexColor("#DFDFDF"),
          body: _isLoading ? Center(
            child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.black87)
            ),
          ) : SingleChildScrollView(
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

                          TextFormField(
                            controller: _emailTextEditingController,
                            keyboardType: TextInputType.emailAddress,
                            style: GoogleFonts.montserrat(
                                fontSize: 18
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "This field can't be empty.";
                              }
                              if (value.length < 10) {
                                return "Please enter a valid E-Mail address!";
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
                          TextFormField(
                            controller: _passwordTextEditingController,
                            keyboardType: TextInputType.name,
                            style: GoogleFonts.montserrat(
                                fontSize: 18
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "This field can't be empty.";
                              }
                              if (value.length < 6) {
                                return "Your password is too short!";
                              }
                              return null;
                            },
                            cursorColor: Colors.black12,
                            cursorWidth: 1,
                            obscureText: true,
                            decoration: InputDecoration(
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black87, width: 2.0),
                                ),
                                border: const OutlineInputBorder(),
                                labelText: "Password",
                                errorStyle: GoogleFonts.montserrat(),
                                labelStyle: GoogleFonts.montserrat(
                                    color: Colors.black.withOpacity(0.6)
                                )
                            ),
                          ),
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
                                  String _email = _emailTextEditingController.text.toString();
                                  String _password = _passwordTextEditingController.text.toString();
                                  _signIn(
                                      _email,
                                      _password
                                  );
                                },
                                child: Text("Sign In", style: GoogleFonts.montserrat(
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
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => SignUpView()),
                                );
                              },
                              child: Text("New here? Sign Up",
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

  _signIn(email, password) async{
    if(_formKey.currentState.validate()){
      setState(() {
        _isLoading = true;
      });
      await _firebaseFunctions.signIn(email, password);
      setState(() {
        _isLoading = false;
      });
    }
  }

}