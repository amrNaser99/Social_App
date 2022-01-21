import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialApp/Module/register/register_screen.dart';
import 'package:socialApp/layout/social_layout.dart';
import 'package:socialApp/shared/components/components.dart';
import 'package:socialApp/shared/components/constants.dart';
import 'package:socialApp/shared/network/local/cache_helper.dart';
import 'package:socialApp/shared/styles/colors.dart';
import 'login_cubit/social_login_cubit.dart';
import 'login_cubit/social_login_states.dart';

class SocialLoginScreen extends StatefulWidget {
  const SocialLoginScreen({Key? key}) : super(key: key);

  @override
  State<SocialLoginScreen> createState() => _SocialLoginScreenState();
}

class _SocialLoginScreenState extends State<SocialLoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isPassword = true;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
          listener: (BuildContext context, state) {
        if (state is SocialLoginErrorStates) {
          showToast(message: state.error);
        }
        if (state is SocialLoginSuccessStates) {
          CacheHelper.saveData(key: 'token', value: token).then((value) {
            print('token Saved Successfully');
          }).catchError((error) {
            print(error);
          });

          CacheHelper.saveData(
            key: 'uId',
            value: state.uId,
          ).then((value) {
            NavigateAndFinish(
              context,
              SocialLayout(),
            );
          }).catchError(
            (error) {
              showToast(message: error);
            },
          );
        }
      }, builder: (BuildContext context, state) {
        return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor),
                        ),
                        Text(
                          'Login Now To Browse Our Offers',
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                color: Colors.grey,
                                fontSize: 14.0,
                              ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultTextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          labelText: 'Email',
                          hintText: 'Email Address',
                          prefixIcon: Icons.email_outlined,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Your Email Address';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        defaultTextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            labelText: 'Password',
                            prefixIcon: Icons.lock_outline,
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password Must\'t Be Empty';
                              }
                            },
                            isPassword: isPassword,
                            suffixIcon: isPassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            suffixPressed: () {
                              setState(() {
                                isPassword = !isPassword;
                              });
                            }),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingStates,
                          builder: (context) => defaultButton(
                            color: primaryColor,
                            text: 'Login',
                            function: () {
                              if (formKey.currentState!.validate()) {
                                SocialLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            isUpperCase: true,
                          ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t Have Account?'),
                            defaultTextButton(
                              onPressed: () {
                                NavigateAndFinish(
                                    context, SocialRegisterScreen());
                              },
                              text: 'Register',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
      }),
    );
  }
}
