import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/log.dart';

class FirebaseController {
  //make fields const or another file for better abstraction, for example... String collectionName = 'person0;
  static createUser(String email, String password) async {
    try {
      Log.printLog('user signup data sending to firebase...');

      final UserCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      Log.printLog(UserCredential.toString());

      //show snackBar.....
    } catch (e) {
      Log.printLog(e.toString());
    }
  }

  static Future<UserCredential?> loginUser(String email, String password) async {
    try {
      Log.printLog('user signup data sending to firebase...');
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      Log.printLog(userCredential.toString());
      return userCredential;
    } on FirebaseAuthException catch (e) {
      Log.printLog(e.toString());
    }
    return null;
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getDataFromDatabase()  {
    final data =  FirebaseFirestore.instance.collection('person').snapshots();
    //Log.printLog(data.toString());
    return  data;
  }
  
  static Stream<QuerySnapshot<Map<String, dynamic>>> getDataFromDatabaseWithQuery(){
    final data = FirebaseFirestore.instance.collection('person').where('uid',isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots();
    return data;
  }

  static  deleteData(String item) {
    FirebaseFirestore.instance.collection('person').doc(item).delete();
    Log.printLog('deleted $item');
  }

  static uploadData(String name, int pin) async {
    // static upload
    final data = await FirebaseFirestore.instance.collection('person').add({'name': name, 'pin': pin});
    Log.printLog(data.toString());
  }

  // similarly update the data....can pass map directly...
  static editData({required String name, required int pin, required String item}) async{
     await FirebaseFirestore.instance.collection('person').doc(item).update({'name':name, 'pin':pin});
    Log.printLog('Data updated');
  }
  static userLogOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Log.printLog("User Log Out");
    } catch (e) {
      Log.printLog(e.toString());
    }
  }
}
