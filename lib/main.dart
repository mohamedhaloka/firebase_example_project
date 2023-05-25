import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eye_can/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextFormField(
            decoration: const InputDecoration(label: Text('E-mail')),
            controller: emailController,
          ),
          TextFormField(
            decoration: const InputDecoration(label: Text('Password')),
            controller: passwordController,
          ),
          loading
              ? const Center(child: CircularProgressIndicator())
              : ElevatedButton(
                  onPressed: () async {
                    if (emailController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      return;
                    }
                    loading = true;
                    setState(() {});
                    //Sign in as Helper
                    try {
                      final UserCredential userCredential = await FirebaseAuth
                          .instance
                          .signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      if (!mounted) return;
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => const BlindsListPage()),
                      );
                    } on FirebaseAuthException catch (e) {
                      log('error=> $e');
                    }
                    loading = false;

                    setState(() {});
                  },
                  child: const Text('Sign in')),
          const SizedBox(height: 30),
          InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SignUpPage()),
                );
              },
              child: Text('Sign Up')),
        ],
      ),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextFormField(
            decoration: const InputDecoration(label: Text('Name')),
            controller: nameController,
          ),
          TextFormField(
            decoration: const InputDecoration(label: Text('Phone')),
            controller: phoneController,
          ),
          TextFormField(
            decoration: const InputDecoration(label: Text('E-mail')),
            controller: emailController,
          ),
          TextFormField(
            decoration: const InputDecoration(label: Text('Password')),
            controller: passwordController,
          ),
          loading
              ? const Center(child: CircularProgressIndicator())
              : ElevatedButton(
                  onPressed: () async {
                    if (emailController.text.isEmpty ||
                        passwordController.text.isEmpty ||
                        phoneController.text.isEmpty ||
                        nameController.text.isEmpty) {
                      return;
                    }
                    loading = true;
                    setState(() {});
                    //Sign Up as Helper
                    try {
                      final UserCredential userCredential = await FirebaseAuth
                          .instance
                          .createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );

                      userCredential.user!
                          .updateDisplayName(nameController.text);
                      await FirebaseFirestore.instance
                          .collection('Helpers')
                          .doc()
                          .set({
                        'blind_name': '',
                        'email': emailController.text,
                        'name': nameController.text,
                        'phone': phoneController.text,
                      });
                      if (!mounted) return;
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => const BlindsListPage()),
                      );
                    } on FirebaseAuthException catch (e) {
                      log('error=> $e');
                    }
                    loading = false;

                    setState(() {});
                  },
                  child: const Text('Sign Up')),
        ],
      ),
    );
  }
}

class BlindsListPage extends StatefulWidget {
  const BlindsListPage({Key? key}) : super(key: key);

  @override
  State<BlindsListPage> createState() => _BlindsListPageState();
}

class _BlindsListPageState extends State<BlindsListPage> {
  List<Map<String, dynamic>> data = [];

  bool loading = true;
  @override
  void initState() {
    _getBlindsList();
    super.initState();
  }

  Future<void> _getBlindsList() async {
    final QuerySnapshot<Map<String, dynamic>> data =
        await FirebaseFirestore.instance.collection('Blind').get();

    for (var element in data.docs) {
      this.data.add(element.data());
    }
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blind List Page'),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              itemBuilder: (_, int index) => Column(
                children: [
                  Text('Blind name: ${data[index]['name']}'),
                  const SizedBox(height: 5),
                  Text('Blind name: ${data[index]['phone']}'),
                ],
              ),
              separatorBuilder: (_, __) => const Divider(),
              itemCount: data.length,
            ),
    );
  }
}
