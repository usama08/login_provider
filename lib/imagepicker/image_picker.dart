import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  String _imagePath = '';
  final ImagePicker _imgPicker = ImagePicker();
  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;
  late firebase_auth.FirebaseAuth _auth;

  @override
  void initState() {
    super.initState();
    _auth = firebase_auth.FirebaseAuth.instance;
    signInAnonymously();
  }

  Future<void> signInAnonymously() async {
    try {
      await _auth.signInAnonymously();
      print('Signed in anonymously');
    } catch (e) {
      print('Failed to sign in anonymously: $e');
    }
  }

  Future<void> getImage() async {
    try {
      final pickedFile = await _imgPicker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          _imagePath = pickedFile.path;
        });
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("Error while picking an image: $e");
    }
  }

  Future<void> pickFromGallery() async {
    try {
      final pickedFile =
          await _imgPicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imagePath = pickedFile.path;
        });
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("Error while picking an image from gallery: $e");
    }
  }

  Future<void> uploadImageToStorage(File file) async {
    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final destination =
          'images/$fileName'; // Change the destination path according to your needs
      await _storage.ref(destination).putFile(file);
      print('Image uploaded successfully.');
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  void uploadButtonPressed() {
    if (_imagePath.isNotEmpty) {
      final file = File(_imagePath);
      uploadImageToStorage(file);
    } else {
      print("No image is selected.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 150),
          Container(
            width: 250,
            height: 150,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: _imagePath.isNotEmpty ? Image.file(File(_imagePath)) : null,
          ),
          const SizedBox(height: 10),
          buildButton(
            title: 'Pick Gallery',
            icon: Icons.image_outlined,
            onClicked: pickFromGallery,
          ),
          const SizedBox(height: 10),
          buildButton(
            title: 'Camera',
            icon: Icons.camera_alt_outlined,
            onClicked: getImage,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: uploadButtonPressed,
            child: const Text('Upload'),
          ),
        ],
      ),
    );
  }

  Widget buildButton({
    required String title,
    required IconData icon,
    required VoidCallback onClicked,
  }) =>
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(56),
          primary: Colors.white,
          onPrimary: Colors.black,
          textStyle: const TextStyle(fontSize: 20),
        ),
        onPressed: onClicked,
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
            ),
            const SizedBox(width: 16),
            Text(title),
          ],
        ),
      );
}
