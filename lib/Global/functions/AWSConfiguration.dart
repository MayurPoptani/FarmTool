import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:farmtool/amplifyconfiguration.dart';

bool isAWSConfigured = false;

Future<void> configureAWS() async {
  try {
    Amplify.addPlugin(AmplifyAuthCognito()).onError((e, stackTrace) {
      print("Amplify.addPlugin onError() = "+e.message??""+" == "+e.recoverySuggestion??""+" == "+e.underlyingException??"");
    });
  } on AmplifyException catch (e) {
    print(e.message??""+" == "+e.recoverySuggestion??""+" == "+e.underlyingException??"");
  }
  try {
    Amplify.configure(amplifyconfig);
  } on AmplifyException catch (e) {
    print("Amplify.addPlugin() AmplifyException = "+e.message??"" + " = " + e.recoverySuggestion??"" + " = " + e.underlyingException??"");
  }
  try {
    await Amplify.configure(amplifyconfig);
  } on AmplifyAlreadyConfiguredException catch(e) {
    print("Amplify.configure() AmplifyAlreadyConfiguredException = "+e.message??"" + " = " + e.recoverySuggestion??"" + " = " + e.underlyingException??"");
  } on AmplifyException catch (e) {
    print("Amplify.configure() AmplifyException = "+e.message??"" + " = " + e.recoverySuggestion??"" + " = " + e.underlyingException??"");
  }
  isAWSConfigured = true;
}