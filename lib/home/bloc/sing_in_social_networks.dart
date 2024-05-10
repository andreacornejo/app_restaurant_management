import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SignInSocialNetworkInProvider extends ChangeNotifier {
  // final _googleSignIn = GoogleSignIn();
  bool _isAuth = false;
  bool _loadingAuth = false;
  bool _loadingValidate = true;
  bool _versionAppValidate = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool get isAuth => _isAuth;
  bool get loadingAuth => _loadingAuth;
  bool get loadingValidate => _loadingValidate;
  bool get versionAppValidate => _versionAppValidate;

  set versionAppValidate(bool state) {
    _versionAppValidate = state;
    notifyListeners();
  }

  set loadingValidate(bool state) {
    _loadingValidate = state;
    notifyListeners();
  }

  set loadingAuth(bool state) {
    _loadingAuth = state;
    notifyListeners();
  }

  set isAuth(bool state) {
    _isAuth = state;
    notifyListeners();
  }

  // User get userInfo => _userInfo;
  set userInfo(User user) {}

  /// validar estado de token de usuario En firebase
  Future<void> validateToken() async {
    try {
      FirebaseAuth.instance.authStateChanges().listen((user) async {
        if (user != null) {
          if (!isAuth) {
            if (kDebugMode) {
              print(
                  "========================habilitando auth==========================");
            }
            var preferencias = await SharedPreferences.getInstance();
            if (preferencias.getString("uid_user") != null) {
              isAuth = true;
            }
          }
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // Future<void> googleAuth() async {
  //   try {
  //     loadingAuth = true;
  //     var googleUser = await _googleSignIn.signIn();
  //     if (googleUser != null) {
  //       var googleAuth = await googleUser.authentication;

  //       var credential = GoogleAuthProvider.credential(
  //         accessToken: googleAuth.accessToken,
  //         idToken: googleAuth.idToken,
  //       );
  //       var resInfo = await _auth.signInWithCredential(credential);
  //       var storage = await SharedPreferences.getInstance();
  //       storage.setString('uid_user', resInfo.user!.uid);
  //       isAuth = true;
  //     }
  //     loadingAuth = false;
  //   } on PlatformException catch (e) {
  //     loadingAuth = false;
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //   }
  // }

  Future<void> emailAuth(String emailAddress, String password) async {
    try {
      loadingAuth = true;

      final credential = await _auth.signInWithEmailAndPassword(
          email: emailAddress, password: password);
      if (credential.user != null) {
        var storage = await SharedPreferences.getInstance();
        storage.setString('uid_user', credential.user!.uid);
        storage.setString('email', emailAddress);
        isAuth = true;
      }

      loadingAuth = false;
    } on PlatformException catch (e) {
      loadingAuth = false;
      if (kDebugMode) {
        print(e);
      }
    } catch (e) {
      loadingAuth = false;
      if (kDebugMode) {
        print(e);
      }
    }
  }

  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  // Future<void> appleAuth() async {
  //   // To prevent replay attacks with the credential returned from Apple, we
  //   // include a nonce in the credential request. When signing in with
  //   // Firebase, the nonce in the id token returned by Apple, is expected to
  //   // match the sha256 hash of `rawNonce`.
  //   try {
  //     final rawNonce = generateNonce();
  //     final nonce = sha256ofString(rawNonce);

  //     // Request credential for the currently signed in Apple account.
  //     final appleCredential = await SignInWithApple.getAppleIDCredential(
  //       scopes: [
  //         AppleIDAuthorizationScopes.email,
  //         AppleIDAuthorizationScopes.fullName,
  //       ],
  //       nonce: nonce,
  //     );

  //     // Create an `OAuthCredential` from the credential returned by Apple.
  //     final oauthCredential = OAuthProvider("apple.com").credential(
  //       idToken: appleCredential.identityToken,
  //       rawNonce: rawNonce,
  //     );

  //     // Sign in the user with Firebase. If the nonce we generated earlier does
  //     // not match the nonce in `appleCredential.identityToken`, sign in will fail.
  //     var resInfo = await _auth.signInWithCredential(oauthCredential);
  //     var storage = await SharedPreferences.getInstance();
  //     storage.setString('uid_user', resInfo.user!.uid);
  //     isAuth = true;
  //     loadingAuth = false;
  //   } on FirebaseAuthException catch (e) {
  //     loadingAuth = false;
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //   } catch (e) {
  //     loadingAuth = false;
  //   }
  // }

  Future<void> logOut() async {
    // await _googleSignIn.signOut();
    var storage = await SharedPreferences.getInstance();
    await storage.clear();
    await FirebaseAuth.instance.signOut();
  }
}
