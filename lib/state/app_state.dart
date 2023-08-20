import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/state/message.dart';

import '../firebase_options.dart';

class AppState extends ChangeNotifier {
  AppState() {
    init();
  }

  late FirebaseFirestore firestore;
  late FirebaseAuth auth;

  bool isLoggedIn = false;

  StreamSubscription? sub;

  final List<Message> messages = [];

  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    firestore = FirebaseFirestore.instance;
    auth = FirebaseAuth.instance;

    auth.authStateChanges().listen((event) {
      if (event == null) {
        sub?.cancel();
        isLoggedIn = false;
        messages.clear();
        return;
      }
      isLoggedIn = true;
      debugPrint(event.uid);
      listenToFirestore();
    });
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<void> signIn() async {
    await auth.signInAnonymously();
  }

  void listenToFirestore() {
    var currentUser = auth.currentUser;
    if (currentUser == null) {
      return;
    }
    sub = firestore
        .collection('vertex')
        .doc(currentUser.uid)
        .collection('messages')
        .withConverter(
          fromFirestore: (snapshot, _) => Message.fromFirestore(snapshot),
          toFirestore: (message, _) => message.toFirestore(),
        )
        .snapshots()
        .listen((event) {
      for (var element in event.docs) {
        debugPrint(element.data().toString());
        messages.add(element.data());
      }
    });
  }

  Future<void> addMessage(String message) async {
    var currentUser = auth.currentUser;
    if (currentUser == null) {
      debugPrint("no user");
      return;
    }
    firestore
        .collection("vertex")
        .doc(currentUser.uid)
        .collection("messages")
        .add({
      "input": message,
      "timestamp": FieldValue.serverTimestamp(),
    }).then((value) => debugPrint("message added"));
  }
}
