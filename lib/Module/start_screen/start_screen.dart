import 'package:flutter/material.dart';
import 'package:twasol/shared/components/components.dart';

import '../auth/login/social_login_screen.dart';
import '../auth/register/register_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              PositionedDirectional(
                top: MediaQuery.of(context).size.height * 0.1,
                start: 0,
                end: 0,
                child: const Image(
                  image: AssetImage(
                    'assets/images/logo.png',
                  ),
                ),
              ),
              PositionedDirectional(
                start: 0,
                end: 0,
                top: MediaQuery.of(context).size.height * 0.45,
                child: Text(
                  'Twasol',
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              PositionedDirectional(
                start: 0,
                end: 0,
                bottom: MediaQuery.of(context).size.height * 0.15,
                child: Padding(
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
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        function: () {
                          NavigateTo(context, const SocialRegisterScreen());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
