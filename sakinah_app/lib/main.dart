import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakinah_app/provider/appController.dart';
import 'package:sakinah_app/screens/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sakinah_app/firebase_options.dart';
// void main() {
//   runApp( MyApp());
// }


Future<void> main() async {
  // initialized firebase.
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            
             apiKey: "AIzaSyBOBB38KvV_P9CV1YkOB21iwgIk5I47Ttw",
  authDomain: "sakinah-17793.firebaseapp.com",
  projectId: "sakinah-17793",
  storageBucket: "sakinah-17793.firebasestorage.app",
  messagingSenderId: "1061299533194",
  appId: "1:1061299533194:web:2723cac1e9c44449f68473",
  measurementId: "G-6C06YG8JY7"
            ));
  } else {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }



  runApp( MyApp());
}



class MyApp extends StatelessWidget {
   MyApp({super.key});

  final appController = Get.put(AppController());

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  SplashScreen(),
    );
  }
}


