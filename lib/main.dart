import 'package:cvpr_projekt/persistent/gpt_api.dart';

import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'router.config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cvpr_projekt/persistent/book_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  BookApi.instance.setKey(dotenv.env['GOOGLE_API_KEY'] ?? '');
  GptApi.instance.setKey(dotenv.env['GPT_KEY'] ?? '');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());

  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}



