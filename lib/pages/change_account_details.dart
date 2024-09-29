import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangeAccountDetailsPage extends StatefulWidget {
  const ChangeAccountDetailsPage({Key? key}) : super(key: key);

  @override
  _ChangeAccountDetailsPageState createState() =>
      _ChangeAccountDetailsPageState();
}

class _ChangeAccountDetailsPageState extends State<ChangeAccountDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userData =
          await _firestore.collection('users').doc(user.uid).get();
      setState(() {
        _nameController.text = userData['name'] ?? '';
        _emailController.text = user.email ?? '';
      });
    }
  }

  Future<void> _updateAccountDetails() async {
    if (_formKey.currentState!.validate()) {
      try {
        User? user = _auth.currentUser;
        if (user != null) {
          // Update name in Firestore
          await _firestore.collection('users').doc(user.uid).update({
            'name': _nameController.text,
          });

          // Update email in Firebase Auth
          if (_emailController.text != user.email) {
            await user.updateEmail(_emailController.text);
          }

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Account details updated successfully')),
          );

          Navigator.pop(context);
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating account details: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Account Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _updateAccountDetails,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[400],
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'Update Account Details',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
