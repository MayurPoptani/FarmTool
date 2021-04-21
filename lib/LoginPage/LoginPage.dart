import 'package:farmtool/Dashboard/Dashboard.dart';
import 'package:farmtool/Global/variables/GlobalVariables.dart';
import 'package:farmtool/Global/widgets/TextFormFieldContainer.dart';
import 'package:farmtool/SignupPage/SignupPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_admin/firebase_admin.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool otpSent = false;

  TextEditingController phoneC = TextEditingController(text: "9527386497");
  TextEditingController pinC = TextEditingController(text: "");

  String? verificationID;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      print("CALLBACK");
      globalUser = FirebaseAuth.instance.currentUser;
      if(globalUser !=null && globalUser!.displayName!=null) Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => Dashboard()), (route) => false);
      else {
        await FirebaseAuth.instance.signOut();
        globalUser = null;
      }
    });
  }

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
                  onChanged: (str) {
                    if(otpSent) setState(() => otpSent = false);
                  },
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
                    child: AnimatedCrossFade(
                      crossFadeState: !otpSent ? CrossFadeState.showFirst : CrossFadeState.showSecond, 
                      duration: Duration(milliseconds: 350,),
                      firstChild: Container(), 
                      secondChild: TextFomFieldContainer(
                        child: TextFormField(
                          controller: pinC,
                          keyboardType: TextInputType.number,
                          maxLength: 6,
                          decoration: InputDecoration(
                            counterText: "",
                            counterStyle: TextStyle(fontSize: double.minPositive),
                            labelText: "OTP",
                            hintText: "6 Digit Pin Number",
                          ),
                        ),
                      ), 
                    ),
                  ),
                  SizedBox(width: 16,),
                  ElevatedButton(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      child: Text(otpSent ? "Login" : "Send OTP", style: TextStyle(color: Colors.white,),),
                    ),
                    onPressed: () {
                      if(!otpSent) requestOTP();
                      else if(pinC.text.trim().length==6 && verificationID!=null) {
                        login(PhoneAuthProvider.credential(verificationId: verificationID!, smsCode: pinC.text.trim()));
                      }
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
                            child: Text("SignUp", style: TextStyle(fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),),
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

  requestOTP() async {
    otpSent = false;
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91"+phoneC.text.trim(),
      timeout: Duration(seconds: 45),
      codeSent: (verificationId, code) {
        if(mounted) setState(() => otpSent = true);
        verificationID = verificationId;
        print("codeSent.verificationId => "+verificationId);
        print("codeSent.code => "+code.toString());
      },
      verificationCompleted: (cred) {
        print("verificationCompleted.verificationId => "+(cred.verificationId??""));
        print("verificationCompleted.smsCode => "+(cred.smsCode??""));
        print("verificationCompleted.providerId => "+(cred.providerId));
        login(cred);
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

  login(PhoneAuthCredential cred) async {
    try {
      var userCred = await FirebaseAuth.instance.signInWithCredential(cred);
      globalUser = userCred.user;
      if(userCred.additionalUserInfo?.isNewUser??false || globalUser!.displayName==null) {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => Signup.fromSignInPage()));
      }
      else Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => Dashboard()), (route) => false);
    } on FirebaseAuthException catch (e) {
      print(e.code+" === "+(e.message??""));
    }
  }
}