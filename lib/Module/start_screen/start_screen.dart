import 'package:flutter/material.dart';
import 'package:twasol/Module/login/social_login_screen.dart';
import 'package:twasol/Module/register/register_screen.dart';
import 'package:twasol/shared/components/components.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
                child: Image(
              image: AssetImage(
                'assets/images/logo.png',
              ),
            )),

            Text(
              'Twasol',
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  ?.copyWith(color: Colors.black, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  defaultButton(
                    text: 'login',
                    isUpperCase: true,
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    function: () {
                      NavigateTo(context, const SocialLoginScreen());
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                  const Text(
                    '- Or -',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  defaultButton(
                    text: 'SIGN UP',
                    function: () {
                      NavigateTo(context, const SocialRegisterScreen());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
