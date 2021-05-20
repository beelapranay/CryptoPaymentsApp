import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFunctions{
  
  String prevCrypto, prevInrBalance;
  double total, inrBalance, afterCryptoTransferSender,
      prevCryptoTransferSender,
      prevCryptoTransferReceiver,
      afterCryptoTransferReceiver;
  String BTC = "39937";

  // String btcPrice, ethPrice, adaPrice, xrpPrice, uniPrice, dotPrice =
  //     "39937" "2650" "1.641" "1.170" "25.12" "27.76";

  Future<void> signUp(String email, String password, String name) async{
     await FirebaseAuth.instance.createUserWithEmailAndPassword
      (email: email,
        password: password);
     await FirebaseAuth.instance.currentUser.updateProfile(displayName: name);
  }

  Future<void> signIn(String email, String password)  {
     FirebaseAuth.instance.signInWithEmailAndPassword
      (email: email,
        password: password);
  }

  Future<void> sendResetMail(String email)  {
     FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
  
  Future<void> initialData(){
    FirebaseFirestore.instance
        .collection("Holdings")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .set({
      "eth": "0",
      "btc": "1.5",
      "ada": "0",
      "xrp": "0",
      "uni": "0",
      "dot": "0",
      "uid": FirebaseAuth.instance.currentUser.uid
    });

    FirebaseFirestore.instance
        .collection("Holdings")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("transfers")
        .add({
      "image": "https://firebasestorage.googleapis.com/v0/b/ca4p-518e4.appspot.com/o/grubhub.png?alt=media&token=61b9316c-05f3-45f9-8759-1ae3717d8c06",
      "status": "Pending",
      "amount": 0.0006
    });

    FirebaseFirestore.instance
        .collection("Holdings")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("transfers")
        .add({
      "image": "https://firebasestorage.googleapis.com/v0/b/ca4p-518e4.appspot.com/o/amazon__logo.png?alt=media&token=cca30ca2-188a-4b66-be45-c5a56232f591",
      "status": "Pending",
      "amount": 0.005
    });

    FirebaseFirestore.instance
        .collection("Holdings")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("transfers")
        .add({
      "image": "https://firebasestorage.googleapis.com/v0/b/ca4p-518e4.appspot.com/o/ps.png?alt=media&token=9a85959c-cfae-44fd-be11-ebfaae05605c",
      "status": "Pending",
      "amount": 0.0014
    });

    FirebaseFirestore.instance
        .collection("Holdings")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("transfers")
        .add({
      "image": "https://firebasestorage.googleapis.com/v0/b/ca4p-518e4.appspot.com/o/xboxlogo.png?alt=media&token=4fc1c0dc-51ad-450d-b7ea-6f82eb21b1e0",
      "status": "Pending",
      "amount": 0.00016,
    });

    FirebaseFirestore.instance
        .collection("Holdings")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("transfers")
        .add({
          "image": "https://firebasestorage.googleapis.com/v0/b/ca4p-518e4.appspot.com/o/rcgames.png?alt=media&token=f007652d-e32d-4971-b3c0-83e7d3be1b61",
          "status": "Pending",
          "amount": 0.0008
    });

    FirebaseFirestore.instance
        .collection("Holdings")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("transfers")
        .add({
      "status": "Pending",
      "amount": 0.0009,
      "image": "https://firebasestorage.googleapis.com/v0/b/ca4p-518e4.appspot.com/o/blizzard.png?alt=media&token=a7d4465f-d3b6-4649-bdf9-5980e907b693"
    });
  }

  Future<String> transferCrypto(String walletAddress, String quantity) async{

    await FirebaseFirestore.instance.collection('Holdings')
        .doc(FirebaseAuth.instance.currentUser.uid)
    // ignore: non_constant_identifier_names
        .get().then((DocumentSnapshot) =>
      {
        prevCryptoTransferSender = double.parse(DocumentSnapshot.get("btc")),
        print(prevCryptoTransferSender)
      }
    );

    await FirebaseFirestore.instance.collection('Holdings')
        .doc(walletAddress)
    // ignore: non_constant_identifier_names
        .get().then((DocumentSnapshot) =>
      {
        print(walletAddress),
        prevCryptoTransferReceiver = double.parse(DocumentSnapshot.get("btc")),
      }
    );

    if(prevCryptoTransferSender < double.parse(quantity)){
      return "Insufficient Funds!";
    }

    else if(walletAddress == FirebaseAuth.instance.currentUser.uid){
      return "Invalid wallet address!";
    }

    else if(prevCryptoTransferSender >= double.parse(quantity)){

      afterCryptoTransferSender = prevCryptoTransferSender - double.parse(quantity);
      afterCryptoTransferReceiver = prevCryptoTransferReceiver + double.parse(quantity);

      await FirebaseFirestore.instance.collection("Holdings")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .update({
        "btc": afterCryptoTransferSender
      });

      await FirebaseFirestore.instance.collection("Holdings")
          .doc(walletAddress)
          .update({
        "btc": afterCryptoTransferReceiver
      });
    }

    return "Success";

  }

  Future<void> updateHoldings(String quantity, String crypto) async{

    await FirebaseFirestore.instance.collection('Holdings')
        .doc(FirebaseAuth.instance.currentUser.uid)
    // ignore: non_constant_identifier_names
        .get().then((DocumentSnapshot) =>
      {
        prevCrypto = DocumentSnapshot.get(crypto),
        //prevInrBalance = DocumentSnapshot.get("inr")
      }
    );


    total = double.parse(prevCrypto) + double.parse(quantity);
    //inrBalance = double.parse(prevInrBalance) - (double.parse(quantity)*double.parse(crypto.toUpperCase()));

    
    FirebaseFirestore.instance
        .collection("Holdings")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update({
        crypto: total.toString(),
        //"inr": inrBalance.toString()
    });
  }
  
}