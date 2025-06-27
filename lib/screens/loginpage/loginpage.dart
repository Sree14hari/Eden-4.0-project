import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  String errorMessage = "";

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> login() async {
    setState(() {
      isLoading = true;
      errorMessage = "";
    });

    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await saveUserToFirestore(userCredential.user);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? "Login failed";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> anonymousLogin() async {
    try {
      final userCredential = await _auth.signInAnonymously();
      await saveUserToFirestore(userCredential.user);
    } catch (e) {
      setState(() {
        errorMessage = "Anonymous login failed";
      });
    }
  }

  Future<void> saveUserToFirestore(User? user) async {
    if (user == null) return;

    final docRef = _firestore.collection('users').doc(user.uid);

    final doc = await docRef.get();
    if (!doc.exists) {
      await docRef.set({
        'uid': user.uid,
        'email': user.email ?? '',
        'created_at': FieldValue.serverTimestamp(),
        'role': 'user',
      });
    }

    // Navigate to home after successful login
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            if (isLoading) const CircularProgressIndicator(),
            if (errorMessage.isNotEmpty)
              Text(errorMessage, style: const TextStyle(color: Colors.red)),
            ElevatedButton(onPressed: login, child: const Text("Login")),
            TextButton(
              onPressed: anonymousLogin,
              child: const Text("Continue as Guest"),
            ),
          ],
        ),
      ),
    );
  }
}
