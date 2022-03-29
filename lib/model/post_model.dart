import 'dart:io';
import 'package:flutter/material.dart';

class PostModel {
  late String? userName;
  late String? uId;
  late String? image;
  late String? dateTime;
  late String? text;
  late String? postImage;
  late String? postId;
  late int? likes;
  late int? nComments;
  var controller = TextEditingController();
  FileSystemEntity? voice;



  PostModel({
    this.userName,
    this.uId,
    this.image,
    this.dateTime,
    this.text,
    this.postImage,
    this.postId,
    this.likes,
    this.nComments,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImage = json['postImage'];
    postId = json['postId'];
    likes = json['likes'];
    nComments = json['nComments'];
    voice = json['voice'];
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'uId': uId,
      'image': image,
      'dateTime': dateTime,
      'text': text,
      'postImage': postImage,
      'nComments': nComments,
      'voice': voice,
    };
  }
}
