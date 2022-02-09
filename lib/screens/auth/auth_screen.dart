import 'package:elomia_test/routes.dart';
import 'package:elomia_test/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
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
              Flexible(
                flex: 2,
                child: _adImg(context),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  color: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12.0)),
                        style: SignInWithAppleButtonStyle.white,
                        text: 'Continue with Apple',
                        height: 48,
                      )
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

  _adImg(BuildContext context) => Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Positioned(
              top: -(1 / MediaQuery.of(context).size.aspectRatio) * 15,
              child: Image.asset(
                'assets/elomia/elomia.png',
                  height: MediaQuery.of(context).size.height *
                      1.35 *
                      MediaQuery.of(context).size.aspectRatio
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
