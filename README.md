# 📱 UFES Bank - App de Transferências
> **Projeto Mobile com Flutter e Firebase**

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)

## 📄 Descrição Geral

O **UFES Bank** é um aplicativo de carteira digital desenvolvido para facilitar a transferência de valores entre contas. O diferencial do projeto é a integração de funcionalidades modernas de pagamento, permitindo que transações sejam iniciadas tanto pela digitação manual do CPF quanto pela **leitura de QR Codes** gerados dinamicamente pelo próprio app.

O sistema utiliza **Firebase Firestore** para autenticação de usuários e persistência de dados em tempo real, garantindo que o saldo seja atualizado instantaneamente após cada transação.

## 📺 Demonstração

Assista ao vídeo de apresentação e funcionamento do aplicativo:
[▶️ Ver Demonstração no YouTube](https://youtu.be/PlM87PBHepA)

---

## 🚀 Funcionalidades Principais

* **🔐 Autenticação Segura:** Login validado diretamente no banco de dados (Firestore) via CPF e senha.
* **💸 Transferência P2P:** Envio de dinheiro entre contas cadastradas utilizando o CPF do destinatário.
* **📷 Leitura de QR Code:** Utiliza a câmera do dispositivo para escanear o QR Code de outro usuário e preencher automaticamente os dados de transferência.
* **🔳 Geração de QR Code:** Cada usuário pode gerar seu próprio QR Code (contendo seu CPF) para receber pagamentos.
* **💰 Saldo em Tempo Real:** Atualização instantânea do saldo na tela inicial após envios ou recebimentos.

---

## 🛠️ Tecnologias e Bibliotecas

O projeto foi construído utilizando as seguintes tecnologias:

* **[Flutter](https://flutter.dev/):** Framework principal para desenvolvimento UI.
* **[Firebase Firestore](https://firebase.google.com/products/firestore):** Banco de dados NoSQL para armazenar usuários, senhas e saldos.
* **[Flutter Barcode Scanner](https://pub.dev/packages/flutter_barcode_scanner):** Para leitura e decodificação dos QR Codes.
* **[QR Flutter](https://pub.dev/packages/qr_flutter):** Para geração e renderização dos QR Codes na tela.
* **[Intl](https://pub.dev/packages/intl):** Para formatação de valores monetários e datas.

---

## 📂 Estrutura do Projeto

A organização do código segue uma arquitetura simples baseada em telas (Pages):

| Arquivo | Responsabilidade |
| :--- | :--- |
| `main.dart` | Ponto de entrada e inicialização do Firebase. |
| `loginpage.dart` | Tela de autenticação (CPF/Senha) e validação no Firestore. |
| `homepage.dart` | Dashboard principal, exibe saldo e menu de ações. |
| `transferpage.dart` | Tela para digitar valor e realizar a transferência. |
| `generateqrcode.dart` | Gera o código visual para receber transferências. |
| `readqrcode.dart` | Ativa a câmera para ler tickets/CPFs de terceiros. |

---

## 🔧 Como Executar o Projeto

### Pré-requisitos
* Flutter SDK instalado.
* Dispositivo físico ou emulador Android/iOS configurado.
* Projeto configurado no Console do Firebase.

### Passo a Passo

1.  **Clone o repositório:**
    ```bash
    git clone [https://github.com/seu-usuario/TransferMoneyApp.git](https://github.com/seu-usuario/TransferMoneyApp.git)
    ```

2.  **Instale as dependências:**
    ```bash
    flutter pub get
    ```

3.  **Configuração do Firebase:**
    * Certifique-se de que o arquivo `firebase_options.dart` está configurado corretamente para o seu projeto ou adicione o arquivo `google-services.json` (Android) / `GoogleService-Info.plist` (iOS) nas pastas nativas.

4.  **Execute o aplicativo:**
    ```bash
    flutter run
    ```

---

## 📝 Observações
Este aplicativo foi desenvolvido como parte de um trabalho acadêmico. A lógica de transação é simplificada (client-side) para fins de demonstração de interface e uso de sensores (câmera).

---
