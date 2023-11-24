import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tourism/model/app_user.dart';

class UserController {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

 

  static final CollectionReference<AppUser> _usersRef =
      _firestore.collection('user').withConverter<AppUser>(
            fromFirestore: (snapshot, _) =>
                AppUser.myFromJsonFuntion(snapshot.data()!),
            toFirestore: (users, _) => users.myToJson(),
          );

  // static Future<AppUser?> getUserDetails(String uid) async {
  //   try {
  //     return await _usersRef
  //         .doc(uid)
  //         .get()
  //         .then((value) => value.exists ? value.data() : null);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }


 static createUser(AppUser users) async{
  try {
    await _usersRef.doc(users.uid).set(users);
    return 'Done';
  } catch (e) {
    
  }
 }
  //int sum( int a, int b)

  // static updateUser(String uid, name, address, phonenumber) async {
  //   try {
  //     await _usersRef.doc(uid).update({
  //       'name': name,
  //       'address': address,
  //       'phonenumber': phonenumber,
  //     });
  //     return 'ok';
  //   } catch (e) {
  //     return 'error';
  //   }
  // }

 

 

 

  

 

  

  // static Future<List<AppUser?>?> getAllUsers() async {
  //   try {
  //     return await _usersRef
  //         .get()
  //         .then((value) => value.docs.map((e) => e.data()).toList());
  //   } catch (e) {
  //     print(e);
  //     return null;
  //   }
  // }

 
}