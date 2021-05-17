import 'package:crypto_payments/Views/reusableWidgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final _formKey = GlobalKey<FormState>();
  ReusableWidgets _reusableWidgets = new ReusableWidgets();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#DFDFDF"),
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: Text("Forgot Password",
            style: GoogleFonts.montserrat(
              fontSize: 20,
              color: Colors.white
            )
          ),
        ),
        body: isLoading ? Center(
          child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.black87)
          ),
        ) :
        Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                _reusableWidgets.textFormField("E-Mail",
                    false,
                    TextInputType.emailAddress),

                SizedBox(height: 20,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: SizedBox(
                    width: double.infinity
                    ,
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      onPressed: (){
                        _forgotPassword();
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

  _forgotPassword() async {
    if(_formKey.currentState.validate()){
      setState(() {
        isLoading = true;
      });
      await Future.delayed(const Duration(seconds: 2), (){});
      setState(() {
        isLoading = false;
      });
    }
  }

}
