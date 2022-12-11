import 'package:flutter/material.dart';
import '../utils.dart';

class MessageField {
  static final String createdAt = 'createdAt';
}

class Message {
  final String senderId;
  final String receiverId;
  final String urlAvatar;
  final String username;
  final String message;
  final DateTime createdAt;

  const Message({
    @required this.receiverId,
    @required this.senderId,
    @required this.urlAvatar,
    @required this.username,
    @required this.message,
    @required this.createdAt,
  });

  static Message fromJson(Map<String, dynamic> json) => Message(
        receiverId: json['receiverId'],
        senderId: json['senderId'],
        urlAvatar: json['urlAvatar'],
        username: json['username'],
        message: json['message'],
        createdAt: Utils.toDateTime(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'senderId': senderId,
        'receiverId':receiverId,
        'urlAvatar': urlAvatar,
        'username': username,
        'message': message,
        'createdAt': Utils.fromDateTimeToJson(createdAt),
      };
}
