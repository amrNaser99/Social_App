import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twasol/shared/cubit/social_cubit.dart';

class CommentScreen extends StatelessWidget {

  String? postId ;


  CommentScreen(this.postId);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        String? postId = this.postId;
        SocialCubit.get(context).getComments(postId!);
        return BlocConsumer(
            listener: (BuildContext context, state) {  },
            builder: (BuildContext context, Object? state) 
            {
              return Scaffold();
            },
        );
      }
    );
  }

}
