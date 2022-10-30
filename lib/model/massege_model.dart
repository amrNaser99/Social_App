import 'dart:io';

class MessageModel {
  String? senderId;
  String? receiverId;
  String? dataTime;
  String? text;
  String? pic;
  FileSystemEntity? voice;

  MessageModel({
    this.senderId,
    this.receiverId,
    this.dataTime,
    this.text,
    this.pic,
    this.voice,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dataTime = json['dataTime'];
    text = json['text'];
    voice = json['voice'];
    pic = json['pic'];
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
