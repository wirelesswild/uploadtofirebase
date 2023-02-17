import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uploadtofirebase/components/constants/app_bar.dart';
import 'package:uploadtofirebase/components/constants/background.dart';
import 'package:uploadtofirebase/components/upload/upload_page.dart';
import 'package:uploadtofirebase/responsive/side_menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyCVteQByf6XbW5o1VElArBb_oAkr4kAbOA",
          appId: "1:167414477854:web:add5cc827c58cf8f4a6a0f",
          messagingSenderId: "167414477854",
          projectId: "wireless-wild-web",
          storageBucket: "gs://wireless-wild-web.appspot.com/"));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Upload());
  }
}
