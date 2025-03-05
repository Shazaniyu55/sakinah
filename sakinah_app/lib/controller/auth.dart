// ignore_for_file: unused_local_variable, avoid_print
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';


class AuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
// static final GoogleSignIn _googleSignIn = GoogleSignIn();

 static final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: kIsWeb ? "1061299533194-tuksvcgmlullleq1heqibkvp0tulie8j.apps.googleusercontent.com" : null, // Add Web Client ID here
  );


  static String verifyId = "";
  // to sent and otp to user
  static Future sentOtp({
    required String phone,
    required Function errorStep,
    required Function nextStep,
  }) async {
    await _firebaseAuth
        .verifyPhoneNumber(
      timeout: const Duration(seconds: 50),
      phoneNumber: "+234$phone",
      verificationCompleted: (phoneAuthCredential) async {
        return;
      },
      verificationFailed: (error) async {
        return;
      },
      codeSent: (verificationId, forceResendingToken) async {
        verifyId = verificationId;
        nextStep();
      },
      codeAutoRetrievalTimeout: (verificationId) async {
        return;
      },
    )
        .onError((error, stackTrace) {
      errorStep();
    });
  }

  // verify the otp code and login
  static Future loginWithOtp({required String otp}) async {
    final cred =
        PhoneAuthProvider.credential(verificationId: verifyId, smsCode: otp);

    try {
      final user = await _firebaseAuth.signInWithCredential(cred);
      if (user.user != null) {
        return "Success";
      } else {
        return "Error in Otp login";
      }
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
  }

  // to logout the user
  static Future logout() async {
    await _firebaseAuth.signOut();
  }


 static Future<UserCredential?> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        // Use signInSilently for Web
        final GoogleSignInAccount? googleUser = await _googleSignIn.signInSilently();
        if (googleUser == null) {
          return null; // User canceled sign-in
        }

        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        return await _firebaseAuth.signInWithCredential(credential);
      } else {
        // Normal sign-in for mobile (Android/iOS)
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        if (googleUser == null) {
          return null; // User canceled sign-in
        }

        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        return await _firebaseAuth.signInWithCredential(credential);
      }
    } catch (e) {
      print("Google Sign-In Error: $e");
      return null;
    }
  }


//  static Future<UserCredential?> signInWithGoogle() async {
//     try {
//        // Trigger the authentication flow
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

//       if (googleUser == null) {
//         return null; // User canceled the sign-in
//       }


//       // Obtain the auth details from the request
//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;


//            // Create a new credential
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       // Sign in to Firebase with the Google credential

//       final UserCredential userCredential =
//           await _firebaseAuth.signInWithCredential(credential);

//         // Store user data in Firestore if it's their first time
//       if (userCredential.additionalUserInfo!.isNewUser) {
//         await FirebaseFirestore.instance
//             .collection("users")
//             .doc(userCredential.user!.uid)
//             .set({
//           "uid": userCredential.user!.uid,
//           "name": userCredential.user!.displayName ?? "No Name",
//           "email": userCredential.user!.email ?? "No Email",
//           "photoURL": userCredential.user!.photoURL ?? "",
//           "accountType": "user", // Default account type
//           "createdAt": FieldValue.serverTimestamp(),
//         });
//       }

//       return userCredential;

//     } catch (e) {
//       print("Error during Google Sign-In: $e");
//       return null;
//     }
//  }

  //THIS FUNCTION AUTHENTICATE ALREADY REGISTERED USERS
  static Future<String?> getAccountType() async {
    try {
      User? user = _firebaseAuth.currentUser;

      if (user != null) {
        // Check each collection for the user's account type
        List<String> collections = [
          'users',
          'ambulance',
          'econsultants',
          'hospital'
        ];

        for (String collection in collections) {
          DocumentSnapshot userProfileDoc = await FirebaseFirestore.instance
              .collection(collection)
              .doc(user.uid)
              .get();

          if (userProfileDoc.exists) {
            return userProfileDoc.get('accountType');
          }
        }
      }

      return null;
    } catch (e) {
      print("Error getting account type: $e");
      return null;
    }
  }
}
