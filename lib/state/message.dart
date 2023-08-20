import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String input;
  final Timestamp? timestamp;
  final String? output;

  Message({
    required this.input,
    this.output,
    this.timestamp,
  });

  factory Message.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return Message(
      input: data?['input'],
      output: data?['output']['predictions'][0]['content'],
      timestamp: data?['timestamp'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'input': input,
      'timestamp': timestamp ?? FieldValue.serverTimestamp(),
    };
  }
}

final messagesQuery = FirebaseFirestore.instance
    .collection('messages')
    .withConverter(
      fromFirestore: (snapshot, idx) => Message.fromFirestore(snapshot),
      toFirestore: (message, idx) => message.toFirestore(),
    )
    .orderBy('time', descending: true);
