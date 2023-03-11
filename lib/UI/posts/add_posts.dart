import 'package:firebase_database/firebase_database.dart';
import 'package:firebasetutorials/UI/posts/post_screen.dart';
import 'package:firebasetutorials/Widgets/round_button.dart';
import 'package:firebasetutorials/utils/utils.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final postController= TextEditingController();
  bool loading=false;
  final databaseRef = FirebaseDatabase.instance.ref('post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Notes'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
              SizedBox(
                height: 30,
              ),
            TextFormField(
              controller: postController,
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'what is in your mind?'
              ),
            ),
            SizedBox(
              height: 30,
            ),
            RoundButton(title: 'Add',loading: loading, ontap: (){
              setState(() {
                loading=true;
              });
              String id = DateTime.now().millisecondsSinceEpoch.toString();
                databaseRef.child(id).set({
                  'id': id,
                  'title': postController.text.toString()

                }).then((value){
                  Utils().toastMessage('Post added');
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen()));
                  setState(() {
                    loading=false;
                  });
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                  setState(() {
                    loading=false;
                  });
                });
            })
          ],
        ),
      ),
    );
  }
}
