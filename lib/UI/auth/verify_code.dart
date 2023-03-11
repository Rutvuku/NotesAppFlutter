import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetutorials/UI/posts/post_screen.dart';
import 'package:flutter/material.dart';

import '../../Widgets/round_button.dart';
import '../../utils/utils.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;
  const VerifyCodeScreen({Key? key, required this.verificationId})
      : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final verificationCodeController = TextEditingController();
  bool loading = false;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            TextFormField(
              controller: verificationCodeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Enter 6 digit code'),
            ),
            SizedBox(
              height: 100,
            ),
            RoundButton(
                title: "Verify",
                loading: loading,
                ontap: ()async {
                  setState(() {
                    loading=true;
                  });
                  final credential = PhoneAuthProvider.credential(verificationId: widget.verificationId, smsCode: verificationCodeController.text.toString());
                  try{
                    await auth.signInWithCredential(credential);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen()));
                  }catch(e){
                    setState(() {
                      loading=false;
                    });
                  }
                })
          ],
        ),
      ),
    );
  }
}
