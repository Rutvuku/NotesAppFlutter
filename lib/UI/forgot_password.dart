import 'package:firebasetutorials/Widgets/round_button.dart';
import 'package:firebasetutorials/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
            SizedBox(height: 40,),
            RoundButton(title: 'forgot', ontap: (){
              setState(() {
                loading=true;
              });
              auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value){
                setState(() {
                  loading=false;
                });
                  Utils().toastMessage('We have sent you an email!!');
              }).onError((error, stackTrace){
                loading=false;
                  Utils().toastMessage(error.toString());
              });
            },loading: loading,)
          ],
        ),
      ),
    );
  }
}
