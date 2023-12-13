import 'package:flutter/material.dart';
import 'package:novo/loginpage.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // Garantindo que os recursos do Flutter estão inicializados
  WidgetsFlutterBinding.ensureInitialized();
  // Inicializando o Firebase com as opções padrão da plataforma atual
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
      },
    );
  }
}
