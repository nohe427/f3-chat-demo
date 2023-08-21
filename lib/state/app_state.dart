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

  List<Message> messages = [];

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
        notifyListeners();
        return;
      }
      isLoggedIn = true;
      debugPrint(event.uid);
      listenToFirestore();
      notifyListeners();
    });
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<void> signIn() async {
    await auth.signInAnonymously();
  }

  Future<void> flipAuthState() async {
    if (isLoggedIn) {
      await signOut();
    } else {
      await signIn();
    }
  }

  void listenToFirestore() {
    debugPrint("Listening to firestore...");
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
        .orderBy('timestamp', descending: true)
        .limit(10)
        .snapshots()
        .listen((event) {
      messages.clear();
      for (var element in event.docs) {
        debugPrint(
            "${element.data().input} \n ${element.data().output ?? ""} ");
        messages.add(element.data());
      }
      notifyListeners();
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
