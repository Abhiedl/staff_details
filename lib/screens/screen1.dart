import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

CollectionReference reference =
    FirebaseFirestore.instance.collection('details');
String imageUrl = '';
final nameController = TextEditingController();
final phoneController = TextEditingController();
final ageController = TextEditingController();
String? dropDownValue;
String? selectedCategory;

class _Screen1State extends State<Screen1> {
  @override
  Widget build(BuildContext context) {
    var items = ["HR", "Finance", "Housekeeping", "Marketing"];

    return Scaffold(
      //key: scaffoldMessengerKey,
      appBar: AppBar(
        title: const Text('Screen 1'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'ENTER STAFF DETAILS',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    hintText: 'Phone',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: ageController,
                  decoration: InputDecoration(
                    hintText: 'Age',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 15,
                ),
                DropdownButton<String>(
                    dropdownColor: const Color.fromARGB(255, 189, 233, 255),
                    hint: const Text('Select Department'),
                    value: dropDownValue,
                    items: (items)
                        .map(
                          (item) => DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                            ),
                            onTap: () {
                              selectedCategory = item;
                            },
                          ),
                        )
                        .toList(),
                    onChanged: (newValue) {
                      setState(() {
                        dropDownValue = newValue!;
                      });
                    }),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 60),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white),
                  onPressed: () async {
                    uploadImage();
                  },
                  icon: const Icon(
                    Icons.camera_alt,
                    size: 30,
                  ),
                  label: const Text(
                    'Upload a photo',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    saveNote();
                  },
                  child: const Text(
                    'Save profile',
                    style: TextStyle(fontSize: 17),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future saveNote() async {
    if (imageUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please upload an image')));
    }

    String id = DateTime.now().microsecondsSinceEpoch.toString();
    String name = nameController.text;
    String phone = phoneController.text;
    String age = ageController.text;
    String imageurl = imageUrl;
    String? department = dropDownValue;
    Map<String, dynamic> dataToSend = {
      'id': id,
      'name': name,
      'phone': phone,
      'age': age,
      'ImageUrl': imageurl,
      'department': department,
    };
    reference.add(dataToSend);

    Get.showSnackbar(const GetSnackBar(
      animationDuration: Duration(seconds: 1),
      duration: Duration(seconds: 1),
      message: "Profile added.",
      isDismissible: true,
      snackPosition: SnackPosition.BOTTOM,
    ));

    nameController.clear();
    phoneController.clear();
    ageController.clear();

    setState(() {
      dropDownValue = null;
    });
  }

  Future uploadImage() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (file == null) {
      return;
    }
    String filename = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref();
    Reference referenceImages = reference.child('images');
    Reference referenceUploadImage = referenceImages.child(filename);
    try {
      await referenceUploadImage.putFile(File(file.path));
      imageUrl = await referenceUploadImage.getDownloadURL();
    } catch (e) {
      return;
    }
    Get.showSnackbar(const GetSnackBar(
      animationDuration: Duration(seconds: 1),
      duration: Duration(seconds: 1),
      message: "Image uploaded.",
      isDismissible: true,
      snackPosition: SnackPosition.BOTTOM,
    ));
  }
}
