import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({
    super.key,
    this.input = "",
    this.output = "",
    this.timestamp,
    this.collection = "chats"
  });

  final String input;
  final String output;
  final Timestamp? timestamp;
  final String collection;

  @override
  Widget build(BuildContext context) {
    var color = collection == "messages" ? Colors.green : Colors.red;
    return Column(
      children: <Widget>[
        BubbleSpecialTwo(
          text: input,
          isSender: true,
          color: color,
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        output != ""
            ? BubbleSpecialTwo(
                text: output,
                isSender: false,
                color: const Color.fromARGB(255, 214, 213, 213),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              )
            : Container(),
        // timestamp != null ? DateChip(date: timestamp!.toDate()) : Container(),
      ],
    );
  }
}
