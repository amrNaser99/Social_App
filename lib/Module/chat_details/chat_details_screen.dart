import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:socialApp/model/user_model.dart';
import 'package:socialApp/shared/styles/colors.dart';
import 'package:socialApp/shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  late UserModel userModel;

  ChatDetailsScreen({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20.0,
                backgroundImage: NetworkImage('${userModel.image}'),
              ),
              const SizedBox(
                width: 15.0,
              ),
              Text(
                '${userModel.userName}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 5.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(10.0),
                    topStart: Radius.circular(10.0),
                    topEnd: Radius.circular(10.0),
                  ),
                ),
                child: Text(
                  'Hello World',
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontSize: 18.0,
                      ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 5.0,
                ),
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: const BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(10.0),
                    topStart: Radius.circular(10.0),
                    topEnd: Radius.circular(10.0),
                  ),
                ),
                child: Text(
                  'Hello World',
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                ),
              ),
            ),
            const Spacer(),
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                border: Border.all(
                  color: greyColor,
                  width: 1.0,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(
                        start: 10.0,
                        end: 10.0,
                      ),
                      child: SizedBox(
                        height: 50.0,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Type Your Massege Here',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50.0,
                    child: MaterialButton(
                      color: mainColor,
                      onPressed: () {},
                      minWidth: 1.0,
                      child: const Icon(
                        IconBroken.Send,
                        size: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
