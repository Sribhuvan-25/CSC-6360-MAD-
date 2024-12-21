import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class PersonalInfoChangePage extends StatefulWidget {
  @override
  _PersonalInfoChangePageState createState() => _PersonalInfoChangePageState();
}

class _PersonalInfoChangePageState extends State<PersonalInfoChangePage> {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Personal Information'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text(_selectedDate == null
                  ? 'Select your Date of Birth'
                  : 'Selected DOB: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}'),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate ?? DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (picked != null && picked != _selectedDate)
                  setState(() {
                    _selectedDate = picked;
                  });
              },
            ),
            ElevatedButton(
              child: Text('Save Changes'),
              onPressed: _saveDOB,
            ),
          ],
        ),
      ),
    );
  }

  void _saveDOB() async {
    if (_selectedDate != null) {
      try {
        await _fireStore
            .collection('users')
            .doc(_firebaseAuth.currentUser!.uid)
            .update({'dob': _selectedDate});
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('DOB updated successfully!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update DOB')),
        );
      }
    }
  }
}
