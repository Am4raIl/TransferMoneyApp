import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQRCode extends StatefulWidget {
  final String cpf;
  final double saldo;
  final Function(double) atualizarSaldo;
  final String? cpfUsuarioLogado;

  GenerateQRCode({
    required this.cpf,
    required this.saldo,
    required this.atualizarSaldo,
    required this.cpfUsuarioLogado,
  });

  @override
  _GenerateQRCodeState createState() => _GenerateQRCodeState();
}

class _GenerateQRCodeState extends State<GenerateQRCode> {
  // Chave global para identificar o widget de repintura
  GlobalKey _globalKey = GlobalKey();
  bool showQRCode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 227, 226, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 187),
        title: Text('Gerar QR Code'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            // Botão para gerar ou ocultar o QR Code
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Color.fromARGB(255, 0, 0, 255)),
                minimumSize: MaterialStateProperty.all(Size(150, 50)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                )),
              ),
              onPressed: () {
                setState(() {
                  showQRCode = !showQRCode;
                });
              },
              icon: const Icon(Icons.qr_code),
              label: const Text('Gerar QR Code'),
            ),
            // Exibe o QR Code se a flag estiver definida como verdadeira
            if (showQRCode)
              RepaintBoundary(
                key: _globalKey,
                child: Container(
                  color: Color.fromARGB(255, 227, 226, 255),
                  child: Center(
                    child: QrImageView(
                      data: widget.cpf,
                      version: QrVersions.auto,
                      size: 200.0,
                      padding: EdgeInsets.all(20.0),
                    ),
                  ),
                ),
              ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
