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
      "btc": "0",
      "ada": "0",
      "xrp": "0",
      "uni": "0",
      "dot": "0",
      "inr": "50000",
      "uid": FirebaseAuth.instance.currentUser.uid
    });

    FirebaseFirestore.instance
        .collection("Holdings")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("transfers")
        .add({
      "name": "GrubHub",
      "isPending": true,
      "amount": 0.00016,
    });

    FirebaseFirestore.instance
        .collection("Holdings")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("transfers")
        .add({
      "name": "GrubHub",
      "isPending": true,
      "amount": 0.00016,
    });

    FirebaseFirestore.instance
        .collection("Holdings")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("transfers")
        .add({
      "name": "GrubHub",
      "isPending": true,
      "amount": 0.00016,
    });

    FirebaseFirestore.instance
        .collection("Holdings")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("transfers")
        .add({
      "name": "GrubHub",
      "isPending": true,
      "amount": 0.00016,
    });

    FirebaseFirestore.instance
        .collection("Holdings")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("transfers")
        .add({
      "name": "GrubHub",
      "isPending": true,
      "amount": 0.00016,
    });

    FirebaseFirestore.instance
        .collection("Holdings")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("transfers")
        .add({
      "name": "GrubHub",
      "isPending": true,
      "amount": 0.00016,
    });

    FirebaseFirestore.instance
        .collection("Holdings")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("transfers")
        .add({
      "name": "GrubHub",
      "isPending": true,
      "amount": 0.00016,
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