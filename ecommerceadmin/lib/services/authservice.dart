import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceadmin/constants/firebaseconstants.dart';
import 'package:ecommerceadmin/core/failure.dart';
import 'package:ecommerceadmin/core/type_defs.dart';
import 'package:ecommerceadmin/models/store.dart';
import 'package:ecommerceadmin/providers/firebaseproviders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final authServiceProvider = Provider((ref) => AuthService(
    firestore: ref.watch(firebaseFirestoreProvider),
    firebaseAuth: ref.watch(firebaseAuthProvider)));

class AuthService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  AuthService({
    required FirebaseFirestore firestore,
    required FirebaseAuth firebaseAuth,
  })  : _firestore = firestore,
        _firebaseAuth = firebaseAuth;

  late Store _storeModel;
  CollectionReference get _stores =>
      _firestore.collection(FirebaseConstants.storesCollection);
  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  FutureEither<Store?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return right(Store(uid: _firebaseAuth.currentUser!.uid));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  FutureEither<Store> signUpWithEmailAndPassword(String? email, String? name,
      String? address, String? phonenumber, String? password,String? image) async {
    try {
      _firebaseAuth
          .createUserWithEmailAndPassword(email: email!, password: password!)
          .then((credential) async {
        if (credential.additionalUserInfo!.isNewUser) {
          _storeModel = Store(
              uid: _firebaseAuth.currentUser!.uid,
              name: name,
              address: address,
              phoneNumber: phonenumber,
              image: image);

          await _stores
              .doc(_firebaseAuth.currentUser!.uid)
              .set(_storeModel.toJson());
        } else {
          _storeModel = await getStoreData(credential.user!.uid).first;
        }
      });

      return right(Store(uid: _firebaseAuth.currentUser!.uid, name: name));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Stream<Store> getStoreData(uid) {
    return _stores
        .doc(uid)
        .snapshots()
        .map((event) => Store.fromJson(event.data() as Map<String, dynamic>));
  }

  Either<dynamic, Future<void>> updateStoreData(Store store) {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    User? currentuser = _firebaseAuth.currentUser;
    final userId = currentuser!.uid.toString();
    try {
      return right(_stores.doc(userId).update(store.toJson()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
