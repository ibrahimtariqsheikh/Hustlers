import 'package:flutter/material.dart';
import 'package:synew_gym/constants/helpers.dart';

class MessageField {
  static const String createdAt = 'createdAt';
}

@immutable
class MessageData {
  const MessageData({
    required this.senderID,
    required this.recieverID,
    required this.urlAvatar,
    required this.username,
    required this.message,
    required this.createdAt,
  });
  final String senderID;
  final String recieverID;
  final String urlAvatar;
  final DateTime createdAt;
  final String username;
  final String message;

  static MessageData fromJson(Map<String, dynamic> json) => MessageData(
        senderID: json['senderID'],
        recieverID: json['recieverID'],
        urlAvatar: json['urlAvatar'],
        username: json['username'],
        message: json['message'],
        createdAt: Helpers.toDateTime(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'senderID': senderID,
        'recieverID': recieverID,
        'urlAvatar': urlAvatar,
        'username': username,
        'message': message,
        'createdAt': Helpers.fromDateTimeToJson(createdAt),
      };
}
