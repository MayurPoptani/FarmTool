import 'package:farmtool/Dashboard/Dashboard.dart';
import 'package:farmtool/Global/variables/ConstantsLabels.dart';
import 'package:farmtool/Global/variables/variables.dart';
import 'package:farmtool/Global/widgets/TextFormFieldContainer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  Signup();
  Signup.fromSignInPage();
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  String? verificationID;

  TextEditingController nameC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController otpC = TextEditingController();
  TextEditingController pinC = TextEditingController();
  TextEditingController confirmPinC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  child: Image.asset("assets/images/farming.png",),
                  width: MediaQuery.of(context).size.width*.75,
                ),
              ),
              SizedBox(height: 16,),
              Row(
                children: [
                  Icon(Icons.account_circle_outlined),
                  SizedBox(width: 8,),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(SIGNUP.SIGN_UP, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                  ),
                ],
              ),
              SizedBox(height: 16,), 
              page1(),
              SizedBox(height: 16,),
              Container(
                width: double.maxFinite,
                child: ElevatedButton(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Text(SIGNUP.CONTINUE_BUTTON_LABEL),
                  ),
                  onPressed: () async {
                    requestOTP();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  page1() => Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFomFieldContainer(
          child: TextFormField(
            controller: nameC,
            decoration: InputDecoration(
              labelText: SIGNUP.FULL_NAME,
              hintText: SIGNUP.FULL_NAME_LABEL
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
              labelText: SIGNUP.PHONE_NUMBER_LABEL,
              hintText: SIGNUP.PHONE_NUMBER_LABEL,
            ),
          ),
        ),
        // SizedBox(height: 16,),
        // TextFomFieldContainer(
        //   child: TextFormField(
        //     controller: pinC,
        //     keyboardType: TextInputType.phone,
        //     maxLength: 6,
        //     decoration: InputDecoration(
        //       counterText: "",
        //       counterStyle: TextStyle(fontSize: double.minPositive),
        //       labelText: "Pin",
        //       hintText: "Enter 6 digit pin"
        //     ),
        //   ),
        // ),
        // SizedBox(height: 16,),
        // TextFomFieldContainer(
        //   child: TextFormField(
        //     controller: confirmPinC,
        //     keyboardType: TextInputType.phone,
        //     maxLength: 6,
        //     decoration: InputDecoration(
        //       counterText: "",
        //       counterStyle: TextStyle(fontSize: double.minPositive),
        //       labelText: "Confirm Pin",
        //       hintText: "Re-enter the 6 digit pin"
        //     ),
        //   ),
        // ),
        SizedBox(height: 32,),
      ],
    ),
  );

  Future<bool> showEnterOTPDialog() async {
    bool isSuccess = false;
    otpC.clear();
    isSuccess = await showDialog<bool?>(
      context: context, 
      builder: (_) => AlertDialog(
        title: Text(SIGNUP.VERIFY_OTP_DIALOG_HEADER),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFomFieldContainer(
              child: TextFormField(
                controller: otpC,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: InputDecoration(
                  counterText: "",
                  counterStyle: TextStyle(fontSize: double.minPositive),
                  labelText: SIGNUP.VERIFY_OTP_DIALOG_OTP_FIELD,
                  hintText: SIGNUP.VERIFY_OTP_DIALOG_OTP_FIELD_LABEL
                ),
              ),
            ),
            SizedBox(height: 16,),
            ElevatedButton(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Text(SIGNUP.VERIFY_OTP_DIALOG_VERIFY_BUTTON_LABEL),
              ),
              onPressed: () {
                if(otpC.text.trim().length==6) Navigator.of(_).pop(true);
              }, 
            )
          ],
        ),
      ),
    )??false;
    return Future.value(isSuccess);
  }

  requestOTP() async {
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91"+phoneC.text.trim(),
      timeout: Duration(seconds: 45),
      codeSent: (verificationId, code) async {
        verificationID = verificationId;
        print("codeSent.verificationId => "+verificationId);
        print("codeSent.code => "+code.toString());
        bool otpEntered = await showEnterOTPDialog();
        if(otpEntered) signUp(PhoneAuthProvider.credential(verificationId: verificationID!, smsCode: otpC.text.trim()));
      },
      verificationCompleted: (cred) {
        print("verificationCompleted.verificationId => "+(cred.verificationId??""));
        print("verificationCompleted.smsCode => "+(cred.smsCode??""));
        print("verificationCompleted.providerId => "+(cred.providerId));
        signUp(cred);
      }, 
      codeAutoRetrievalTimeout: (String verificationId) {
        if(mounted) setState(() => verificationID = null);
        print("codeAutoRetrievalTimeout.verificationId => "+verificationId);
      },
      verificationFailed: (error) {
        print("verificationFailed.message => "+(error.message??""));
      }
    );
  }

  signUp(PhoneAuthCredential cred) async {
    try {
      var userCred = await FirebaseAuth.instance.signInWithCredential(cred);
      globalUser = userCred.user;
      globalUser!.updateProfile(displayName: nameC.text.trim());
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => Dashboard()), (route) => false);
    } on FirebaseAuthException catch (e) {
      print(e.code+" === "+(e.message??""));
    }
  }
}