import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'transferpage.dart';

class QRCodePage extends StatefulWidget {
  final String cpf;
  final double saldo;
  final Function(double) atualizarSaldo;
  const QRCodePage(
      {Key? key,
      required this.cpf,
      required this.saldo,
      required this.atualizarSaldo})
      : super(key: key);

  @override
  State<QRCodePage> createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  String ticket = '';
  List<String> tickets = [];

  readQRCode() async {
    String code = await FlutterBarcodeScanner.scanBarcode(
      "#FFFFFF",
      "Cancelar",
      false,
      ScanMode.QR,
    );

    if (code != '-1') {
      bool ticketExists = await checkTicketExists(code);

      if (ticketExists) {
        setState(() => ticket = code);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return TransferScreen(
            saldo: widget.saldo,
            atualizarSaldo: widget.atualizarSaldo,
            cpfUsuarioLogado: widget.cpf,
            cpfDestinoInicial: ticket,
          );
        }));
      } else {
        setState(() => ticket = 'Não validado');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Perfil não encontrado. Não foi possível realizar a transferência.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      setState(() => ticket = 'Não validado');
    }
  }

  Future<bool> checkTicketExists(String ticket) async {
    var collection = FirebaseFirestore.instance.collection('users');
    var querySnapshot = await collection.where('cpf', isEqualTo: ticket).get();

    return querySnapshot.docs.isNotEmpty;
  }

  // Construção da interface da tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Configuração da aparência da tela
      backgroundColor: Color.fromARGB(255, 227, 226, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 187),
        title: Text('Escanear QR Code'),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Exibe o ticket se houver
            if (ticket != '')
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Text(
                  'Ticket: $ticket',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            // Botão para iniciar a leitura do QR Code
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Color.fromARGB(255, 0, 0, 255)),
                minimumSize: MaterialStateProperty.all(Size(150, 50)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                )),
              ),
              onPressed: readQRCode,
              icon: const Icon(Icons.qr_code_scanner),
              label: const Text('Scan QR Code'),
            ),
          ],
        ),
      ),
    );
  }
}
