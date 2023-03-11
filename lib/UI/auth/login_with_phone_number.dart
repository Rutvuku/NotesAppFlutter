import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetutorials/UI/auth/verify_code.dart';
import 'package:firebasetutorials/Widgets/round_button.dart';
import 'package:firebasetutorials/utils/utils.dart';
import 'package:flutter/material.dart';


class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({Key? key}) : super(key: key);

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  final phoneNumberController = TextEditingController();
  bool loading=false;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            TextFormField(
              controller: phoneNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '+1 234 456 78'
              ),
            ),
            SizedBox(height: 100,),

            RoundButton(title: "Login",loading: loading, ontap: (){
              setState(() {
                loading = true;
              });
              auth.verifyPhoneNumber(
                phoneNumber: phoneNumberController.text,
                  verificationCompleted: (_){
                   setState(() {
                     loading=false;
                   });
                  },
                  verificationFailed: (e){
                  setState(() {
                    loading=false;
                  });
                    Utils().toastMessage(e.toString());
                  },
                  codeSent: (String verificationID , int? token){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifyCodeScreen(verificationId: verificationID,)));
                      setState(() {
                        loading=false;
                      });
                  },
                  codeAutoRetrievalTimeout: (e){
                  setState(() {
                    loading=false;
                  });
                    Utils().toastMessage(e.toString());
                  },
              );
            }

            )
          ],
        ),
      ),
    );
  }
}
