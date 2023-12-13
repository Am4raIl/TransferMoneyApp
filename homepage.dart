import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:novo/readqrcode.dart';
import 'package:novo/transferpage.dart';
import 'generateqrcode.dart';
import 'loginpage.dart';

class HomePage extends StatefulWidget {
  final String nome;
  final String email;
  final double saldo;
  final String? cpf;

  HomePage(
      {required this.nome,
      required this.email,
      required this.saldo,
      this.cpf,
      Key? key})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double saldo = 0;

  @override
  void initState() {
    super.initState();
    saldo = widget.saldo;
  }

  void atualizarSaldo(double novoSaldo) {
    setState(() {
      saldo = novoSaldo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 227, 226, 255),
      appBar: AppBar(
        title: Text('Banco UFES'),
        backgroundColor: Color.fromARGB(255, 0, 0, 187),
      ),
      drawer: Drawer(
        // Menu lateral
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: [
                // Cabeçalho do menu
                UserAccountsDrawerHeader(
                  accountEmail:
                      Text(widget.email, style: TextStyle(fontSize: 15)),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 0, 0, 187),
                  ),
                  currentAccountPicture: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset('assets/images/avatar.png'),
                  ),
                  accountName:
                      Text(widget.nome, style: TextStyle(fontSize: 20)),
                ),
                // Opções do menu
                ListTile(
                  leading: Icon(Icons.qr_code),
                  title: Text('Gerar QR Code'),
                  subtitle: Text('Gerar código para transferência'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GenerateQRCode(
                          cpf: widget.cpf ?? '',
                          saldo: saldo,
                          atualizarSaldo: atualizarSaldo,
                          cpfUsuarioLogado: widget.cpf,
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.qr_code_scanner),
                  title: Text('Escanear QR Code'),
                  subtitle: Text('Escanear QR Code para transferência'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QRCodePage(
                                cpf: widget.cpf ?? '',
                                saldo: saldo,
                                atualizarSaldo: atualizarSaldo,
                              )),
                    );
                  },
                ),
              ],
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              subtitle: Text('Finalizar Sessão'),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Saudação ao usuário
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Bem-vindo(a), ${widget.nome}!',
                      style: TextStyle(fontSize: 22)),
                ),
              ),
            ),
            Container(height: 40),
            Image.asset('assets/images/marca_ufes.png',
                width: 500, height: 100),
            Container(
              height: 40,
            ),
            // Exibição do saldo do usuário
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Saldo: R\$ ${NumberFormat.currency(locale: 'pt_BR', symbol: '', decimalDigits: 2).format(saldo)}',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    // Botão para navegar para a página de transferência
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 0, 0, 255)),
                        minimumSize: MaterialStateProperty.all(Size(150, 50)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                      ),
                      onPressed: () async {
                        final novoSaldo = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TransferScreen(
                              saldo: saldo,
                              atualizarSaldo: atualizarSaldo,
                              cpfUsuarioLogado: widget.cpf,
                            ),
                          ),
                        );
                        if (novoSaldo != null) {
                          atualizarSaldo(novoSaldo);
                        }
                      },
                      child: Text('Transferir'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
