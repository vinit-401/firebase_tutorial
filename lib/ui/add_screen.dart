import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/controllers/controller.dart';
import 'package:untitled/uitls/util.dart';

GlobalKey<FormState> _addFormKey = GlobalKey();

class AddScreen extends StatefulWidget {
 const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _pinController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        title: Text('Add Data'),
      ),
      body: Form(
        key: _addFormKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            spacing: 15,
            children: [
              TextFormField(
                controller: _nameController,
                validator: (value) {
                  if (value != null) {
                    if (value.trim().length < 3) {
                      return 'Minimum 3 Characters are required';
                    } else if (value.isEmpty) {
                      return 'required field';
                    }
                  }
                  return null;
                },
                decoration: decoration('Name'),
              ),
              TextFormField(
                  controller: _pinController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value != null) {
                      if (value.trim().length < 3) {
                        return 'Minimum 3 Characters are required';
                      } else if (value.isEmpty) {
                        return 'required field';
                      }
                    }
                    return null;
                  },
                  decoration: decoration('Pin')),
              TextButton(
                onPressed: () {
                  if (_addFormKey.currentState!.validate()) {
                    FirebaseController.uploadData(_nameController.text.trim(), int.parse(_pinController.text.trim()));
                    _pinController.clear();
                    _nameController.clear();
                    Navigator.pop(context);
                  }
                },
                child: Text('Add'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
