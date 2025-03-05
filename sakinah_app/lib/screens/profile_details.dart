// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({super.key});

  @override
  _ProfileDetailsScreenState createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {

  Uint8List? _image;

  final picker = ImagePicker();
  final TextEditingController _firstNameController = TextEditingController(text: "David");
  final TextEditingController _lastNameController = TextEditingController(text: "Peterson");
  String _selectedDate = "Choose birthday date";

  Future<void> _pickImage() async {
    Uint8List? pickedFile = (await picker.pickImage(source: ImageSource.gallery)) as Uint8List?;
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 50),
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {},
                child: Text("Skip", style: TextStyle(color: Colors.red, fontSize: 18)),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Profile details",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildProfileImage(),
            SizedBox(height: 20),
            _buildTextField("First name", _firstNameController),
            SizedBox(height: 15),
            _buildTextField("Last name", _lastNameController),
            SizedBox(height: 20),
            _buildBirthdayButton(context),
            SizedBox(height: 30),
            _buildConfirmButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: _image != null ? MemoryImage(_image!) : AssetImage("images/avatarman.png") as ImageProvider,
        ),
        InkWell(
          onTap: _pickImage,
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Colors.red,
            child: Icon(Icons.camera_alt, color: Colors.white, size: 18),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String hintText, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildBirthdayButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_today, color: Colors.red),
            SizedBox(width: 10),
            Text(
              _selectedDate,
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        minimumSize: Size(double.infinity, 50),
      ),
      child: Text("Confirm", style: TextStyle(fontSize: 18, color: Colors.white)),
    );
  }
}
