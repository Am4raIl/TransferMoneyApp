import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  String? cpf;

  Future<void> realizarLogin() async {
    var collection = FirebaseFirestore.instance.collection('users');
    var querySnapshot =
        await collection.where('cpf', isEqualTo: _cpfController.text).get();

    if (querySnapshot.docs.isNotEmpty) {
      var user = querySnapshot.docs.first;

      if (user['senha'] == _senhaController.text) {
        // Credenciais corretas, obter dados do usuário
        String nome = user['nome'];
        String email = user['email'];
        cpf = user['cpf'];

        // Navegar para a página inicial com os dados do usuário
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
              nome: nome,
              email: email,
              saldo: user['saldo'],
              cpf: cpf,
            ),
          ),
        );
      } else {
        exibirMensagemErro('Senha incorreta! Tente novamente.');
      }
    } else {
      exibirMensagemErro('Usuário não encontrado! Tente novamente.');
    }
  }

  void exibirMensagemErro(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        duration: Duration(milliseconds: 1000),
      ),
    );
  }

  Future<double?> obterSaldoUsuario(String cpf) async {
    var collection = FirebaseFirestore.instance.collection('users');
    var querySnapshot = await collection.where('cpf', isEqualTo: cpf).get();

    if (querySnapshot.docs.isNotEmpty) {
      var user = querySnapshot.docs.first;
      return user['saldo'];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 227, 226, 255),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Faça o seu Login'),
        backgroundColor: Color.fromARGB(255, 0, 0, 187),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/logo.png',
                width: 500,
                height: 100,
              ),
              Container(
                height: 60,
              ),
              Text(
                'Faça o seu Login',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                width: 250,
                child: TextField(
                  controller: _cpfController,
                  decoration: InputDecoration(labelText: 'CPF'),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 250,
                child: TextField(
                  controller: _senhaController,
                  decoration: InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 20),
              // Botão de login
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Color.fromARGB(255, 0, 0, 187)),
                  minimumSize: MaterialStateProperty.all(
                    Size(100, 50),
                  ),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
                ),
                onPressed: () {
                  realizarLogin();
                },
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
