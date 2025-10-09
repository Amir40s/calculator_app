
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:smart_construction_calculator/config/exception/failures.dart';
import 'package:smart_construction_calculator/config/exception/type_def.dart';
import 'package:smart_construction_calculator/config/model/user_model.dart';
import 'package:smart_construction_calculator/config/utility/app_utils.dart';

class UserRepository {
  UserRepository._privateConstructor();
  static final UserRepository instance = UserRepository._privateConstructor();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FutureEither<UserModel?> getCurrentUser() async {
    try {
      User? firebaseUser = _auth.currentUser;
      if (firebaseUser == null) return right(null);

      DocumentSnapshot doc = await _firestore.collection('users').doc(firebaseUser.uid).get();
      if (!doc.exists) return right(null);

      return right(UserModel.fromFirestore(doc));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  

  Stream<int> getUnreadNotificationCount(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .where('isRead', isEqualTo: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  FutureVoid updateUserProfile(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.id).update(user.toMap());
      await AppUtils.uploadNotificationToFirebase(
        title: 'Profile Updated',
        body: 'Your profile has been updated',   uid: FirebaseAuth.instance.currentUser!.uid  ,
      );
      return right(null);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid logout() async {
    try {
      await _auth.signOut();
      // await GoogleSignIn().signOut();
      return right(null);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
