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
    var output = data?['output']; //['predictions'][0]['content'];
    if (output == null) {
      output = "";
    } else {
      output = output; // ['predictions'][0]['content'];
    }
    return Message(
      input: data?['input'],
      output: output,
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
