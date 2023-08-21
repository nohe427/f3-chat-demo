import 'dart:js_interop';

import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  ChatMessage({
    super.key,
    this.input = "",
    this.output = "",
    this.timestamp,
  });

  String input;
  String output;
  Timestamp? timestamp;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        BubbleSpecialTwo(
          text: input,
          isSender: true,
          color: const Color.fromARGB(255, 111, 19, 168),
          textStyle: TextStyle(
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
                textStyle: TextStyle(
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
