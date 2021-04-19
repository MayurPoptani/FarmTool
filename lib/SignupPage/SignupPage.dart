import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:farmtool/Dashboard/Dashboard.dart';
import 'package:farmtool/Global/variables/Colors.dart';
import 'package:farmtool/Global/variables/GlobalVariables.dart';
import 'package:farmtool/Global/widgets/TextFormFieldContainer.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  TextEditingController nameC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController otpC = TextEditingController();
  TextEditingController pinC = TextEditingController();
  TextEditingController confirmPinC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: greenScaffoldColor,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Image.asset("assets/images/farming.png",),
                        height: MediaQuery.of(context).size.height*.4,
                      ),
                      SizedBox(height: 16,),
                      Row(
                        children: [
                          Icon(Icons.account_circle_outlined),
                          SizedBox(width: 8,),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text("SignUp", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                          ),
                        ],
                      ),
                      SizedBox(height: 16,),
                      TextFomFieldContainer(
                        child: TextFormField(
                          controller: nameC,
                          decoration: InputDecoration(
                            labelText: "Full Name",
                            hintText: "First Middle Last"
                          ),
                        ),
                      ),
                      SizedBox(height: 16,),
                      TextFomFieldContainer(
                        child: TextFormField(
                          controller: phoneC,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          decoration: InputDecoration(
                            counterText: "",
                            counterStyle: TextStyle(fontSize: double.minPositive),
                            labelText: "Phone Number",
                            hintText: "10 digit phone number",
                          ),
                        ),
                      ),
                      SizedBox(height: 16,),
                      Row(
                        children: [
                          Expanded(
                            child: TextFomFieldContainer(
                              child: TextFormField(
                                controller: otpC,
                                keyboardType: TextInputType.number,
                                maxLength: 6,
                                decoration: InputDecoration(
                                  counterText: "",
                                  counterStyle: TextStyle(fontSize: double.minPositive),
                                  labelText: "OTP",
                                  hintText: "6 digit number"
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16,),
                          ElevatedButton(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                              child: Text("Send OTP"),
                            ),
                            onPressed: () {
                              // sendOTP();
                              signUp();
                            }, 
                          )
                        ],
                      ),
                      SizedBox(height: 16,),
                      TextFomFieldContainer(
                        child: TextFormField(
                          controller: pinC,
                          keyboardType: TextInputType.phone,
                          maxLength: 6,
                          decoration: InputDecoration(
                            counterText: "",
                            counterStyle: TextStyle(fontSize: double.minPositive),
                            labelText: "Pin",
                            hintText: "Enter 6 digit pin"
                          ),
                        ),
                      ),
                      SizedBox(height: 16,),
                      TextFomFieldContainer(
                        child: TextFormField(
                          controller: confirmPinC,
                          keyboardType: TextInputType.phone,
                          maxLength: 6,
                          decoration: InputDecoration(
                            counterText: "",
                            counterStyle: TextStyle(fontSize: double.minPositive),
                            labelText: "Confirm Pin",
                            hintText: "Re-enter the 6 digit pin"
                          ),
                        ),
                      ),
                      SizedBox(height: 32,), 
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16,),
              Container(
                width: double.maxFinite,
                child: ElevatedButton(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Text("Open My Account"),
                  ),
                  onPressed: () {
                    signUp();
                    // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => Dashboard()), (route) => false);
                  }, 
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  sendOTP() async {
    print("Sending OTP");
    try {
      var res = await Amplify.Auth.resendSignUpCode(username: "+91"+phoneC.text.trim(),);
      print(res.codeDeliveryDetails.attributeName??"");
      print(res.codeDeliveryDetails.deliveryMedium??"");
      print(res.codeDeliveryDetails.destination??"");
      print("OTP Sent");
    } on AuthException catch (e) {
      print("Failed to send OTP");
      print(e.toString());
    }
  }

  signUp() async {
    try {
      Map<String, String> userAttributes = {'phone_number': '+91'+phoneC.text.trim(), "name" : nameC.text.trim()};
      SignUpResult res = await Amplify.Auth.signUp(
        username: "+91"+phoneC.text.trim(),
        password: pinC.text.trim(),
        options: CognitoSignUpOptions(userAttributes: userAttributes)
      );
      print("isSignUpComplete = "+res.isSignUpComplete.toString());
      if(res.isSignUpComplete) {
        // sendOTP();
        gUser = await Amplify.Auth.getCurrentUser();
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => Dashboard()), (route) => false);
      }
    } on UserNotConfirmedException catch (e) {
      print("===UserNotConfirmedException===\n"+e.toString());
      print("RESENDING SIGNUP CODE");
      // var res = await Amplify.Auth.resendSignUpCode(username: '+91'+phoneC.text.trim());
      // print(res.codeDeliveryDetails.toString());
    } on AuthException catch (e) {
      print(e.message);
      print(e.underlyingException);
    }
  }

}