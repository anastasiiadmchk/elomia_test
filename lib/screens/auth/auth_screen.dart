import 'package:elomia_test/routes.dart';
import 'package:elomia_test/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [ElomiaTheme.indigo, Colors.black]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 450,
              child: _adImg(),
            ),
            Container(
              color: Colors.black,
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'Meet Elomia',
                      style: ElomiaTheme.header,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 24.0),
                    child: Text(
                      'An AI-powered companion that helps to improve mental health',
                      style: ElomiaTheme.title,
                    ),
                  ),
                  SignInWithAppleButton(
                    onPressed: () async {
                      // final authData =
                      //     await BlocProvider.instance.authBloc.getAuthData();
                      Navigator.of(context)
                          .pushReplacementNamed(Routes.concernsScreen);
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                    style: SignInWithAppleButtonStyle.white,
                    text: 'Continue with Apple',
                    height: 48,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _adImg() => Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Positioned(
              top: -50,
              child: Image.asset(
                'assets/elomia/elomia.png',
                height: 522,
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 29.0),
              child: Image.asset('assets/chat/chat_preview.png'),
            ),
          ),
        ],
      );
}
