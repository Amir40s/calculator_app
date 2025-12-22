import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/config/exception/failures.dart';
import 'package:smart_construction_calculator/config/exception/type_def.dart';
import 'package:smart_construction_calculator/config/model/user_model.dart';
import 'package:smart_construction_calculator/config/res/app_constants.dart';
import 'package:smart_construction_calculator/config/utility/app_utils.dart';

class AuthRepository {
  AuthRepository._privateConstructor();
  static final AuthRepository instance = AuthRepository._privateConstructor();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

 Future<Either<Failure, UserModel>> signup({required UserModel user}) async {
  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: user.email!,
      password: user.password,
    );
    User? firebaseUser = userCredential.user;
    if (firebaseUser != null) {
        UserModel newUser = user.copyWith(id: firebaseUser.uid);
      return right(newUser);
    } else {
      return left(Failure('User creation failed.'));
    }
  } on FirebaseAuthException catch (e) {
    return left(Failure(e.message ?? 'Unknown error'));
  } catch (e) {
    return left(Failure(e.toString()));
  }
}



Future<Either<Failure, void>> saveUserToFirestore(UserModel user) async {
  try {
    await _firestore.collection('users').doc(user.id).set(user.toFirestore());
    return right(null);
  } catch (e) {
    return left(Failure(e.toString()));
  }
}

  FutureEither<UserModel> login({required UserModel user}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: user.email!,
        password: user.password,
      );

      DocumentSnapshot doc = await _firestore.collection('users').doc(userCredential.user?.uid).get();
      if (!doc.exists) return left(Failure('User data not found'));

      await AppUtils.uploadNotificationToFirebase(
        title: 'Logged In',
        body: 'Welcome back to Prayly',
        uid: FirebaseAuth.instance.currentUser!.uid,
      );
      await userC.loadCurrentUser();
      return right(UserModel.fromFirestore(doc));
    } on FirebaseAuthException catch (e) {
      return left(Failure(e.message ?? 'Unknown error'));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }


  FutureEither<UserModel> continueWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return left(Failure('Google Sign-In aborted'));
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential;
      try {
        userCredential = await _auth.signInWithCredential(credential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          return left(Failure('This email is already registered with a different sign-in method'));
        }
        rethrow;
      }

      User? firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        return left(Failure('Google authentication failed'));
      }

      DocumentSnapshot userDoc = await _firestore.collection('users').doc(firebaseUser.uid).get();

      // split displayName into firstName + lastName
      String? displayName = firebaseUser.displayName;
      String firstName = "";
      String lastName = "";

      if (displayName != null && displayName.isNotEmpty) {
        List<String> parts = displayName.split(" ");
        firstName = parts.isNotEmpty ? parts.first : "";
        lastName = parts.length > 1 ? parts.sublist(1).join(" ") : "";
      }

      UserModel user = UserModel(
        id: firebaseUser.uid,
        email: firebaseUser.email ?? 'guest@example.com',
        userType: UserType.google,
        firstName: firstName,
        lastName: lastName,
        image: firebaseUser.photoURL,
      );

      if (!userDoc.exists) {
        await _firestore.collection('users').doc(firebaseUser.uid).set(user.toFirestore());
        await AppUtils.uploadNotificationToFirebase(
          title: 'Account Created',
          body: 'Welcome to UHConst',
          uid: FirebaseAuth.instance.currentUser!.uid,
        );
      } else {
        user = UserModel.fromFirestore(userDoc);
        await AppUtils.uploadNotificationToFirebase(
          title: 'Logged In',
          body: 'Welcome back to UHConst',
          uid: FirebaseAuth.instance.currentUser!.uid,
        );
      }
      await userC.loadCurrentUser();

      return right(user);
    } on FirebaseAuthException catch (e) {
      return left(Failure(e.message ?? 'Google Sign-In failed'));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid sendPasswordResetEmail({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(Failure(e.message ?? 'Failed to send reset email'));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<bool> checkEmailExist({required String email}) async {
    try {
      final doc = await _firestore.collection('users').where('email', isEqualTo: email).get();

      final exists = doc.docs.isNotEmpty;
      return right(exists);
    } on FirebaseAuthException catch (e) {
      return left(Failure(e.message ?? 'Failed to send reset email'));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid logout() async {
    try {
      await _auth.signOut();
      return right(null);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
