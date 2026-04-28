<div align="center">

# 🏦 UFES Bank
### Aplicativo de Carteira Digital com Flutter & Firebase

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)](https://firebase.google.com)

*Transferências P2P via CPF e QR Code, com saldo em tempo real.*

[▶ Ver Demonstração no YouTube](https://youtu.be/PlM87PBHepA) · [Repositório](https://github.com/Am4raIl/TransferMoneyApp)

</div>

---

## 📄 Sobre o Projeto

O **UFES Bank** é uma carteira digital desenvolvida como projeto acadêmico na **Universidade Federal do Espírito Santo**, com foco em demonstrar a integração entre Flutter, Firebase Firestore e sensores de câmera. O app permite transferências entre contas tanto por digitação de CPF quanto por leitura de **QR Codes gerados dinamicamente pelo próprio aplicativo**. O saldo é atualizado em tempo real após cada transação.

---

## 🚀 Funcionalidades

| Funcionalidade | Descrição |
|:---|:---|
| 🔐 **Autenticação via CPF** | Login validado diretamente no Firestore com CPF e senha |
| 💸 **Transferência P2P** | Envio de valores entre contas cadastradas usando o CPF do destinatário |
| 📷 **Leitura de QR Code** | Câmera acionada para escanear o QR Code de outro usuário e pré-preencher a transferência |
| 🔳 **Geração de QR Code** | Cada usuário pode gerar seu próprio QR Code (com CPF embutido) para receber pagamentos |
| ⚡ **Saldo em Tempo Real** | Dashboard atualiza o saldo instantaneamente após envios e recebimentos |
| 🛡️ **Validação de Destinatário** | O CPF de destino é verificado no Firestore antes de concluir qualquer transação |

---

## 🛠️ Tecnologias e Bibliotecas

| Tecnologia | Uso no Projeto |
|:---|:---|
| [Flutter](https://flutter.dev) | Framework principal para desenvolvimento UI multiplataforma |
| [Firebase Firestore](https://firebase.google.com/products/firestore) | Banco de dados NoSQL em nuvem para usuários, senhas e saldos |
| [qr_flutter](https://pub.dev/packages/qr_flutter) `^4.1.0` | Geração e renderização de QR Codes na tela |
| [flutter_barcode_scanner](https://pub.dev/packages/flutter_barcode_scanner) `^2.0.0` | Leitura e decodificação de QR Codes via câmera |
| [intl](https://pub.dev/packages/intl) `^0.18.1` | Formatação de valores monetários (R$ pt-BR) |
| [firebase_core](https://pub.dev/packages/firebase_core) `^2.22.0` | Inicialização do Firebase no app |

---

## 📂 Estrutura do Projeto

```
TransferMoneyApp/
├── lib/
│   ├── main.dart               # Ponto de entrada e inicialização do Firebase
│   ├── firebase_options.dart   # Configurações geradas pelo FlutterFire CLI
│   ├── loginpage.dart          # Autenticação por CPF/Senha com consulta ao Firestore
│   ├── homepage.dart           # Dashboard com saldo, menu lateral e ações
│   ├── transferpage.dart       # Formulário e lógica de transferência entre contas
│   ├── generateqrcode.dart     # Tela para gerar QR Code pessoal para receber pagamentos
│   └── readqrcode.dart         # Câmera para escanear QR Codes e iniciar transferência
├── assets/
│   └── images/                 # Logotipos e avatar
└── pubspec.yaml
```

---

## 🔧 Como Executar

### Pré-requisitos

- [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado (Dart ≥ 3.1.5)
- Dispositivo físico ou emulador Android/iOS configurado
- Projeto configurado no [Console do Firebase](https://console.firebase.google.com)

### Passo a Passo

**1. Clone o repositório**
```bash
git clone https://github.com/Am4raIl/TransferMoneyApp.git
cd TransferMoneyApp
```

**2. Instale as dependências**
```bash
flutter pub get
```

**3. Configure o Firebase**

Certifique-se de que o `firebase_options.dart` está apontando para o seu projeto Firebase. Ou adicione os arquivos de configuração nas pastas nativas:
```
android/app/google-services.json       # Android
ios/Runner/GoogleService-Info.plist    # iOS
```

**4. Execute o aplicativo**
```bash
flutter run
```

---

## 🗃️ Estrutura do Banco de Dados (Firestore)

A coleção `users` armazena os dados de cada conta:

```json
{
  "cpf":   "12345678900",
  "nome":  "Maria Silva",
  "email": "maria@ufes.br",
  "senha": "senha123",
  "saldo": 1500.00
}
```

> 💡 **Nota:** A autenticação é feita com consulta direta ao Firestore (sem Firebase Authentication). Para produção, recomenda-se migrar para Firebase Auth e mover a lógica de transferência para **Cloud Functions**.

---

## ⚠️ Segurança e Limitações

> **Atenção:** As chaves de API do Firebase presentes em `firebase_options.dart` estão expostas no repositório público. Isso é aceitável para projetos acadêmicos com regras de segurança restritas no Firestore, mas **nunca deve ser feito em produção**.

Limitações conhecidas do projeto por ser um trabalho acadêmico:

- A lógica de transferência é processada **client-side** (sem backend dedicado)
- Senhas armazenadas em **texto simples** no Firestore
- Sem proteção contra condições de corrida em transferências simultâneas

---

## 📝 Observações Acadêmicas

Este aplicativo foi desenvolvido como trabalho acadêmico na **UFES**. O objetivo principal é demonstrar a integração de tecnologias mobile modernas — especialmente o uso da câmera como sensor e a sincronização de dados em tempo real via Firebase. A arquitetura simplificada é intencional para fins didáticos.

---

<div align="center">

Desenvolvido como projeto acadêmico · **UFES Bank** · Flutter + Firebase

</div>
