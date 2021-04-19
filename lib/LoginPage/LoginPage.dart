import 'package:farmtool/Dashboard/Dashboard.dart';
import 'package:farmtool/Global/variables/GlobalVariables.dart';
import 'package:farmtool/Global/widgets/TextFormFieldContainer.dart';
import 'package:farmtool/SignupPage/SignupPage.dart';
import 'package:flutter/material.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController phoneC = TextEditingController(text: "9527386497");
  TextEditingController pinC = TextEditingController(text: "123456");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: greenScaffoldColor,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Image.asset("assets/images/farming.png", 
                width: MediaQuery.of(context).size.width*.75,
              ),),
              SizedBox(height: 16,),
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Icon(Icons.account_circle_outlined, size: 40,),
                    SizedBox(width: 8,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Login", style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black, height: 1,
                          shadows: [BoxShadow(color: Colors.white30, blurRadius: 8, offset: Offset(-2, 2),),],
                        ),),
                        Text("to your account", style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black54, height: 1,
                          shadows: [BoxShadow(color: Colors.white30, blurRadius: 8, offset: Offset(-2, 2),),],
                        ),),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24,),
              TextFomFieldContainer(
                child: TextFormField(
                  controller: phoneC,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: InputDecoration(
                    counterText: "",
                    counterStyle: TextStyle(fontSize: double.minPositive),      
                    labelText: "Phone Number",
                    hintText: "10 Digit Pin Number",
                    prefix: Text("+91 ")
                  ),
                ),
              ),
              SizedBox(height: 16,),
              Row(
                children: [
                  Expanded(
                    child: TextFomFieldContainer(
                      child: TextFormField(
                        controller: pinC,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        decoration: InputDecoration(
                          counterText: "",
                          counterStyle: TextStyle(fontSize: double.minPositive),
                          labelText: "Pin Number",
                          hintText: "6 Digit Pin Number",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16,),
                  ElevatedButton(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      child: Text("Login", style: TextStyle(color: Colors.white,),),
                    ),
                    onPressed: () {
                      signIn();
                    },
                  ),
                ],
              ),
              SizedBox(height: 16,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text("Forgot Pin? Click Here", style: TextStyle(fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),),
                      ),
                    ),
                    SizedBox(width: 16,),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (_) => Signup()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Signup", style: TextStyle(fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  signIn() async {
    try {
      await Amplify.Auth.signOut();
      SignInResult result =  await Amplify.Auth.signIn(
        username: "+91"+phoneC.text.trim(), 
        password: pinC.text.trim(),
      );
      if(result.isSignedIn) {
        print("SIGN IN SUCCESS");
        gUser = await Amplify.Auth.getCurrentUser();
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => Dashboard()), (route) => false);
      } else {
        // TODO: Promt user that id pass are wrong, check input
        print("SING IN FAILURE");
        print(result.nextStep.signInStep + " = " + result.nextStep.additionalInfo.toString());
      }
      
    } on UserNotConfirmedException catch (e) {
      print("===UserNotConfirmedException===\n"+e.toString());
      print("RESENDING SIGNUP CODE");
      Amplify.Auth.resendSignUpCode(username: "+91"+phoneC.text.trim());
      // print(res.codeDeliveryDetails.toString());
    } on UserNotFoundException catch (e) {
      print("=== USER NOT FOUND EXCEPTION");
      print(e.message + " = " + e.recoverySuggestion + " = " + e.underlyingException);
    } on AuthException catch (e) {
      print("=== AUTH EXCEPTION");
      print(e.message + " = " + e.recoverySuggestion + " = " + e.underlyingException);
    }
  }

}