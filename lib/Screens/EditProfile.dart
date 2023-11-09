import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class EditProfilePictureScreen extends StatefulWidget {
  @override
  _EditProfilePictureScreenState createState() =>
      _EditProfilePictureScreenState();
}

class _EditProfilePictureScreenState extends State<EditProfilePictureScreen> {
  File? _image;

  // Function to open the photo picker and select an image
  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  // Function to upload the selected image and save its URL in the database
  Future<void> _uploadImage() async {
    if (_image != null) {
      // Upload the image to your server or cloud storage
      // Replace 'your_upload_url' with your actual upload endpoint
      var request = http.MultipartRequest('POST', Uri.parse('your_upload_url'));

      request.files.add(await http.MultipartFile.fromPath('image', _image!.path));

      final response = await request.send();
      final imageUrl = await response.stream.bytesToString();

      // Save the imageUrl in the 'user' table's 'profile_pic' column
      // Make an HTTP request to your API or use a database package (e.g., sqflite) to update the profile_pic in the user table
      // Example:
      // final updateUserResponse = await http.post('your_update_profile_pic_api_url', body: {'profile_pic': imageUrl});

      // Display a message to the user indicating the upload was successful
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile picture uploaded successfully'),
        ),
      );
    } else {
      // Display an error message if no image is selected
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select an image first'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile Picture'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
  Text(
    'Upload or change your profile picture here.',
    style: TextStyle(fontSize: 18),
  ),
  SizedBox(height: 20),
  ElevatedButton(
    onPressed: _getImage, // Open photo picker
    child: Text('Select Picture'),
  ),
  SizedBox(height: 20),
  ElevatedButton(
    onPressed: _uploadImage, // Upload selected picture
    child: Text('Upload Picture'),
  ),
  if (_image != null) // Render the Image widget conditionally
    Column(
      children: [
        SizedBox(height: 20),
        Image.file(_image!), // Display the selected image
      ],
    ),
],

        ),
      ),
    );
  }
}
