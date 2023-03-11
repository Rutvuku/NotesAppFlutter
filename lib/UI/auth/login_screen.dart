import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetutorials/UI/auth/login_with_phone_number.dart';
import 'package:firebasetutorials/UI/auth/signup_screen.dart';
import 'package:firebasetutorials/UI/auth/verify_code.dart';
import 'package:firebasetutorials/UI/forgot_password.dart';
import 'package:firebasetutorials/UI/posts/post_screen.dart';
import 'package:firebasetutorials/Widgets/round_button.dart';
import 'package:firebasetutorials/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading =false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isHovering=false;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  void login(){
    setState(() {
      loading=true;
    });
    _auth.signInWithEmailAndPassword(email: emailController.text.toString(), password: passwordController.text.toString()).then((value) {
       Utils().toastMessage(value.user!.email.toString());
       Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen()));
       setState(() {
         loading=false;
       });
    }).onError((error, stackTrace) {
        debugPrint(error.toString());
        Utils().toastMessage(error.toString());
        setState(() {
          loading=false;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Login'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: const InputDecoration(
                          hintText: 'Email',

                          prefixIcon: Icon(Icons.alternate_email),
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter email id';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'password',

                          prefixIcon: Icon(Icons.lock),
                        ),
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Enter password';
                            }
                            return null;
                          }
                      )
                    ],
                  )),
              SizedBox(height: 50,),
              RoundButton(
                title: 'Login',
                loading: loading,
                ontap: () {
                      if(_formKey.currentState!.validate()){
                            login();
                      }
                },
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
                  }, child: Text("Sign up")),
                ],
              ),
              SizedBox(height: 20,),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordScreen()));
              }, child: Text("Forgot Password?")),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginWithPhoneNumber()));

                } ,
                onHover: (hovering){
                  setState(() {
                    isHovering=hovering;
                  });
                },
                child: AnimatedContainer(
                  height: 50,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.ease,

                  decoration: BoxDecoration(
                    color: isHovering ? Colors.deepPurple : Colors.green,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                      child: Text('Login with Phone',style: TextStyle(color: Colors.white),),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
