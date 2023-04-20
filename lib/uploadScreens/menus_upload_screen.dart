import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:raidereats_sellers_app/global/global.dart';
import 'package:raidereats_sellers_app/mainScreens/home_screen.dart';
import 'package:raidereats_sellers_app/widgets/progress_bar.dart';
import 'package:firebase_storage/firebase_storage.dart' as storageRef;
import '../widgets/error_dialog.dart';

class MenusUploadScreen extends StatefulWidget {
  const MenusUploadScreen({Key? key}) : super(key: key);

  @override
  _MenusUploadScreenState createState() => _MenusUploadScreenState();
}

class _MenusUploadScreenState extends State<MenusUploadScreen> {

  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();


  TextEditingController shortInfoController = TextEditingController();
  TextEditingController titleController = TextEditingController();


  bool uploading = false;
  String uniqueIdName = DateTime.now().millisecondsSinceEpoch.toString();

  defaultScreen()
  {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration:const  BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.red,
                Colors.black,
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        title: const Text(
          "Uploading New Menu",
          style: TextStyle(fontSize: 30, fontFamily: "Bebas"),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: ()
          {
            Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
          },
        ),
      ),
      body: Container(
        decoration:const  BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.red,
              Colors.black,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shop_two, color: Colors.grey, size: 200.0,),
              ElevatedButton(
                child: const Text(
                  "Add New Menu",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                onPressed: ()
                {
                  takeImage(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  takeImage(mContext)
  {
    return showDialog(
      context: mContext,
      builder: (context)
        {
          return SimpleDialog(
            title:  const Text("Menu Image", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
            children: [
              SimpleDialogOption(
                child: const  Text(
                  "Capture with Camera",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: captureImageWithCamera,
              ),
              SimpleDialogOption(
                child: const Text(
                  "Select from Gallery",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: pickImageFromGallery,
              ),
              SimpleDialogOption(
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: ()=> Navigator.pop(context),
              ),
            ],
          );
        },
    );
  }

  captureImageWithCamera() async
  {
    Navigator.pop(context);
    imageXFile = await _picker.pickImage(
        source: ImageSource.camera,
      maxHeight: 720,
      maxWidth: 1280,
    );

    setState(() {
      imageXFile;
    });
  }

  pickImageFromGallery() async
  {

    Navigator.pop(context);
    imageXFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 720,
      maxWidth: 1280,
    );

    setState(() {
      imageXFile;
    });


  }
  menusUploadFormScreen()
  {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration:const  BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.red,
                Colors.black,
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        title: const Text(
          "Uploading New Menu",
          style: TextStyle(fontSize: 20, fontFamily: "Bebas"),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: ()
          {
            clearMenusUploadForm();
          },
        ),
        actions: [
          TextButton(
            child: const Text(
              "Add",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: "Bebas",
                  letterSpacing: 3,
              ),
            ),
            onPressed: uploading ? null : ()=> validateUploadForm(),
          ),
        ],
      ),
      body: ListView(
        children: [
          uploading == true ? linearProgress() : const Text(""),
          Container(
            height: 230,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16/9,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(
                          File(imageXFile!.path)
                      ),
                        fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.black,
            thickness: 3,
          ),
          ListTile(
            leading: const Icon(Icons.perm_device_information, color: Colors.red,),
            title: Container(
              width: 250,
              child:TextField(
                style: const TextStyle(color: Colors.black),
                controller: shortInfoController,
                decoration: const InputDecoration(
                  hintText: "Menu info",
                  hintStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.black,
            thickness: 3,
          ),
          ListTile(
            leading: const Icon(Icons.title, color: Colors.red,),
            title: Container(
              width: 250,
              child:TextField(
                style: const TextStyle(color: Colors.black),
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: "Menu Title",
                  hintStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.black,
            thickness: 3,
          ),
        ],
      ),
    );
  }

  clearMenusUploadForm()
  {
   setState(() {
     shortInfoController.clear();
     titleController.clear();
     imageXFile = null;
   });
  }

  validateUploadForm() async
  {
    setState(() {
      uploading = true;
    });

    if(imageXFile != null)
      {
        if(shortInfoController.text.isNotEmpty && titleController.text.isNotEmpty)
          {
            setState(() {
              uploading = true;
            });


            //upload image
            String downloadUrl = await uploadImage(File(imageXFile!.path));

            // save info to firebase
            saveInfo(downloadUrl);
          }
        else
          {
            showDialog(
                context: context,
                builder: (c)
                {
                  return ErrorDialog(
                    message: "Please write title and info for menu.",
                  );
                }
            );
          }
      }
    else
      {
        showDialog(
            context: context,
            builder: (c)
            {
              return ErrorDialog(
                message: "Please pick an image for menu",
              );
            }
        );
      }
  }

  saveInfo(String downloadUrl)
  {
    final ref = FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("menus");

    ref.doc(uniqueIdName).set({

      "menuID": uniqueIdName,
      "sellerUID": sharedPreferences!.getString("uid"),
      "menuInfo": shortInfoController.text.toString(),
      "menuTitle": titleController.text.toString(),
      "publishedDate": DateTime.now(),
      "status" : "available",
      "thumbnailUrl": downloadUrl,
    });

    clearMenusUploadForm();

    setState(() {
      uniqueIdName = DateTime.now().millisecondsSinceEpoch.toString();
      uploading = false;
    });
  }

  uploadImage(mImageFile) async
  {
    storageRef.Reference reference = storageRef.FirebaseStorage
        .instance
        .ref()
        .child("menus");

    storageRef.UploadTask uploadTask = reference.child(uniqueIdName + ".jpg").putFile(mImageFile);

    storageRef.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

    String downloadURL = await taskSnapshot.ref.getDownloadURL();

    return downloadURL;
  }

  @override
  Widget build(BuildContext context)
  {

    return imageXFile == null ? defaultScreen() : menusUploadFormScreen();
  }
}
