import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:twasol/shared/styles/colors.dart';
import 'package:twasol/shared/styles/icon_broken.dart';

Widget defaultButton({
  double width = double.infinity,
  Color? color,
  required String text,
  required void Function() function,
  bool isUpperCase = true,
}) =>
    Container(
      width: width,
      height: 40.0,
      child: MaterialButton(
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: function,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: color,
      ),
    );

void NavigateTo(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
    );

void NavigateAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => Widget), (route) => false);

Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType keyboardType,
  required String? labelText,
  String? hintText,
  required IconData prefixIcon,
  FormFieldValidator<String>? validate,
  IconData? suffixIcon,
  void Function(String)? onSubmitted,
  void Function(String)? onChanged,
  void Function()? onTap,
  void Function()? suffixPressed,
  bool isPassword = false,
  double radius = 10.0,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(radius)),
        prefixIcon: Icon(prefixIcon),
        hintText: hintText,
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(suffixIcon),
                onPressed: suffixPressed,
              )
            : null,
      ),
      onChanged: onChanged,
      onTap: onTap,
      validator: validate,
      onFieldSubmitted: onSubmitted,
    );

Widget defaultTextButton({
  required Function()? onPressed,
  required String text,
}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
      ),
    );

void showToast({
  required String message,
}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) =>
     AppBar(
      leading: IconButton(
        icon: const Icon(IconBroken.Arrow___Left_2),
        onPressed: ()
        {
          Navigator.pop(context);
        },
      ),
      titleSpacing: 5.0,
      title: Text(title!),
      actions: actions,
    );

Widget buildListSItem(data, context, index) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(data.image!),
                  height: 120.0,
                  width: 120.0,
                ),
                if (data.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 9.0),
                    ),
                  ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name!,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        height: 1.3,
                        fontSize: 18.0,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: 5.0,
                        start: 5.0,
                      ),
                      child: Row(
                        children: [
                          Text(
                            '${data.price} LE',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: primaryColor,
                              height: 1.3,
                              fontSize: 14.0,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          if (data.discount != 0)
                            Text(
                              '${data.oldPrice} LE',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  height: 1.3,
                                  fontSize: 10.0,
                                  decoration: TextDecoration.lineThrough),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget myDivider() => Padding(
  padding: const EdgeInsets.symmetric(
    horizontal: 15.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);