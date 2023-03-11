import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebasetutorials/Widgets/round_button.dart';
import 'package:firebasetutorials/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? _image;
  bool loading = false;
  DatabaseReference databaseRef = FirebaseDatabase.instance.ref('post');
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  final picker = ImagePicker();
  Future getImageGallery()async{
    final pickedFile= await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if(pickedFile!=null){
        _image= File(pickedFile.path);
      }
      else{
        print('no image selected');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: InkWell(
          onTap: (){
            getImageGallery();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                Center(
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black
                      )
                    ),
                    child: _image!=null? Image.file(_image!.absolute): Icon(Icons.image),
                  ),
                ),
              SizedBox(
                height: 40,
              ),
              RoundButton(title: 'Upload', ontap: ()async{
                setState(() {
                  loading=true;
                });
                  firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('/foldername/'+DateTime.now().millisecondsSinceEpoch.toString());
                  firebase_storage.UploadTask uploadTask = ref.putFile(_image!.absolute);
                   Future.value(uploadTask).then((value)async{
                    var newURL = await ref.getDownloadURL();

                    databaseRef.child('1').set({
                      'id' : '1212',
                      'title' : newURL.toString()
                    }).then((value) {
                      Utils().toastMessage('uploaded');
                      setState(() {
                        loading = false;
                      });
                    }).onError((error, stackTrace) {
                      Utils().toastMessage(error.toString());
                      setState(() {
                        loading = false;
                      });
                    });
                  }).onError((error, stackTrace){
                    Utils().toastMessage(error.toString());
                  });




              } , loading: loading,)
            ],
          ),
        ),
      ),
    );
  }
}
