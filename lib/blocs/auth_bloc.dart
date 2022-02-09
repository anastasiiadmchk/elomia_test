import 'package:elomia_test/models/auth_data.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthBloc {
  AuthBloc();
  final _authData = BehaviorSubject<AuthData>();
  Stream<AuthData> get authData => _authData.stream;

  Future<AuthData> getAuthData() async {
    if (_authData.hasValue) {
      return _authData.value;
    }
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    final data = AuthData(credential);
    if (credential.state != null) {
      _authData.add(data);
    }
    return data;
  }
}
