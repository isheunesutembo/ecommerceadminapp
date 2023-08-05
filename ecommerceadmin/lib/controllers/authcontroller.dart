import 'dart:io';

import 'package:ecommerceadmin/models/store.dart';
import 'package:ecommerceadmin/services/authservice.dart';
import 'package:ecommerceadmin/services/storageservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
    (ref) => AuthController(
        authService: ref.watch(authServiceProvider),
        ref: ref,
        storageService: ref.watch(storageServiceProvider)));
final storeProvider = StateProvider<Store?>((ref) => null);
final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

class AuthController extends StateNotifier<bool> {
  final AuthService _authService;
  final Ref _ref;
  final StorageService _storageService;
  AuthController(
      {required AuthService authService,
      required Ref ref,
      required StorageService storageService})
      : _authService = authService,
        _ref = ref,
        _storageService = storageService,
        super(false);
  Stream<User?> get authStateChange => _authService.authStateChange;
  void signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    state = true;
    final user = await _authService.signInWithEmailAndPassword(email, password);
    state = false;
    user.fold(
        (failure) => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(failure.message))),
        (storeModel) =>
            _ref.read(storeProvider.notifier).update((state) => storeModel));
  }

  signUpWithEmailAndPassword(
    BuildContext context,
    String? email,
    String? name,
    String? address,
    String? phonenumber,
    String? password,
    File? image,
  ) async {
    state = true;
    String storeId = Uuid().v1();
    final imageRes = await _storageService.storeFile(
      path: "storeimages/",
      id: storeId,
      file: image!,
    );
    imageRes.fold(
        (l) => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(l.message))), (r) async {
      final user = await _authService.signUpWithEmailAndPassword(
          email, name, address, phonenumber, password, r.toString());
      state = false;
      user.fold(
          (failure) => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(failure.message))),
          (storeModel) =>
              _ref.read(storeProvider.notifier).update((state) => storeModel));
    });
  }

  Future<void> signOut() async {
    _authService.signOut();
  }

  Stream<Store> getStoreData(uid) {
    return _authService.getStoreData(uid);
  }
}
