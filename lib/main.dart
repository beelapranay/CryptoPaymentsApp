import 'package:crypto_payments/Views/buyCrypto.dart';
import 'package:crypto_payments/Views/forgotPassword.dart';
import 'package:crypto_payments/Views/homeView.dart';
import 'package:crypto_payments/Views/profileView.dart';
import 'package:crypto_payments/Views/signInView.dart';
import 'package:crypto_payments/Views/signUpView.dart';
import 'package:crypto_payments/Views/transferCrypto.dart';
import 'package:crypto_payments/Views/walletView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver{

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        routes: <String, WidgetBuilder>{
          '/signIn': (BuildContext context) => SignInView(),
          '/home': (BuildContext context) => HomeController(),
          '/signUp': (BuildContext context) => SignUpView(),
          '/forgotPassword': (BuildContext context) => ForgotPassword(),
          '/walletView': (BuildContext context) => WalletView(),
          '/profileView': (BuildContext context) => ProfileView(),
          '/market': (BuildContext context) => BuyCrypto(),
          '/cryptoPayments': (BuildContext context) => CryptoPayments()
        },
        home: HomeController()
    );
  }
}

class HomeController extends StatefulWidget {
  @override
  _HomeControllerState createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              final bool signedIn = snapshot.hasData;
              if(signedIn == true){
                return HomeView();
              }
              else if(signedIn == false){
                return SignUpView();
              }
            }
            return Container(height: 0,);
          },
        )
    );
  }
}

