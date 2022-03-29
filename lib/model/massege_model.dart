import 'dart:io';

class MessageModel {
  late String? senderId;
  late String? receiverId;
  late String? dataTime;
  late String? text;
  late FileSystemEntity? voice;

  MessageModel({
    this.senderId,
    this.receiverId,
    this.dataTime,
    this.text,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dataTime = json['dataTime'];
    text = json['text'];
    voice = json['voice'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'dataTime': dataTime,
      'text': text,
      'voice': voice,
    };
  }
}
