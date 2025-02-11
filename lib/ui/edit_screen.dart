import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../controllers/controller.dart';
import '../uitls/util.dart';

GlobalKey<FormState> _editFormKey = GlobalKey();
class EditScreen extends StatefulWidget {
  final  QueryDocumentSnapshot docs;
  const EditScreen({super.key, required this.docs});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {

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
    _nameController.text = widget.docs.get('name');
    _pinController.text = widget.docs.get('pin').toString();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: Text('Edit Data'),
      ),
      body: Form(
        key: _editFormKey,
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
                  if (_editFormKey.currentState!.validate()) {
                    FirebaseController.editData(name: _nameController.text.trim(), pin: int.parse(_pinController.text.trim()), item: widget.docs.id);
                    _pinController.clear();
                    _nameController.clear();
                    Navigator.pop(context);
                  }
                },
                child: Text('Edit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
