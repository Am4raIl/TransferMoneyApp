import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransferScreen extends StatefulWidget {
  final double saldo;
  final Function(double) atualizarSaldo;
  final String? cpfUsuarioLogado;
  final String? cpfDestinoInicial;

  TransferScreen({
    required this.saldo,
    required this.atualizarSaldo,
    this.cpfUsuarioLogado,
    this.cpfDestinoInicial,
  });

  @override
  _TransferScreenState createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  TextEditingController cpfController = TextEditingController();
  TextEditingController valorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Inicializa o controlador do CPF com o valor inicial (se disponível)
    cpfController.text = widget.cpfDestinoInicial ?? '';
  }

  void realizarTransferencia() async {
    try {
      // Obtém o CPF de destino e o valor da transferência
      String cpfDestino = cpfController.text;
      double valorTransferencia = double.tryParse(valorController.text) ?? 0;
      double novoSaldo = widget.saldo - valorTransferencia;

      // Verifica se o CPF de destino não está vazio
      if (cpfDestino.isEmpty) {
        exibirMensagemErro('CPF não pode estar vazio.');
        return;
      }

      // Verifica se o saldo é suficiente para a transferência
      if (widget.saldo < valorTransferencia || valorTransferencia <= 0) {
        exibirMensagemErro('Valor inválido! Tente novamente.');
        return;
      }

      // Verifica se o CPF de destino é válido e diferente do CPF de origem
      if (await validarCPF(cpfDestino) &&
          cpfDestino != widget.cpfUsuarioLogado) {
        // Realiza a transferência
        double novoSaldoRemetente = widget.saldo - valorTransferencia;
        widget.atualizarSaldo(novoSaldoRemetente);

        // Obtém o saldo atual do destinatário
        var destinatarioRef =
            FirebaseFirestore.instance.collection('users').doc(cpfDestino);
        var destinatarioDoc = await destinatarioRef.get();

        // Atualiza o saldo do remetente
        var remetenteRef = FirebaseFirestore.instance
            .collection('users')
            .doc(widget.cpfUsuarioLogado);
        await remetenteRef.update({'saldo': novoSaldo});
        if (destinatarioDoc.exists) {
          double saldoDestinatario = destinatarioDoc.data()?['saldo'] ?? 0;

          // Atualiza o saldo do destinatário
          double novoSaldoDestinatario = saldoDestinatario + valorTransferencia;
          await destinatarioRef.update({'saldo': novoSaldoDestinatario});
          Navigator.pop(context, novoSaldoRemetente);
        } else {
          exibirMensagemErro(
              'Usuário de destino não encontrado. Tente novamente.');
        }
      } else {
        exibirMensagemErro('CPF inválido ou não encontrado. Tente novamente.');
      }
    } catch (e, stackTrace) {
      print('Erro durante a transferência: $e\n$stackTrace');
      exibirMensagemErro(
          'Ocorreu um erro durante a transferência. Tente novamente.');
    }
  }

  Future<bool> validarCPF(String cpf) async {
    var collection = FirebaseFirestore.instance.collection('users');
    var querySnapshot = await collection.where('cpf', isEqualTo: cpf).get();
    return querySnapshot.docs.isNotEmpty;
  }

  void exibirMensagemErro(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        duration: Duration(milliseconds: 1000),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 227, 226, 255),
      appBar: AppBar(
        title: Text('Transferir Dinheiro'),
        backgroundColor: Color.fromARGB(255, 0, 0, 187),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Exibição do saldo atual
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Saldo Atual: \nR\$ ${NumberFormat.currency(locale: 'pt_BR', symbol: '').format(widget.saldo)}',
                    style: TextStyle(fontSize: 20, height: 1.4),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Container(
              height: 10,
            ),
            // Campo para inserir o CPF do destinatário
            SizedBox(
              width: 250,
              child: TextField(
                controller: cpfController,
                keyboardType: TextInputType.number,
                decoration:
                    InputDecoration(labelText: 'Digite o CPF do Destinatário'),
              ),
            ),
            Container(
              height: 10,
            ),
            // Campo para inserir o valor da transferência
            SizedBox(
              width: 250,
              child: TextField(
                controller: valorController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Digite o Valor'),
              ),
            ),
            Container(
              height: 10,
            ),
            // Botão para realizar a transferência
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                onPressed: () {
                  realizarTransferencia();
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Color.fromARGB(255, 0, 0, 255)),
                  minimumSize: MaterialStateProperty.all(Size(150, 50)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
                ),
                child: Text(
                  'Pronto',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
