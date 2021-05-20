import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class GetXController extends GetxController{
  var name = FirebaseAuth.instance.currentUser.displayName.obs;
  var imgUrl = FirebaseAuth.instance.currentUser.photoURL.obs;
}