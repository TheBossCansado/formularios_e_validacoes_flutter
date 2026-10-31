import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const CadastroApp());
}

class CadastroApp extends StatelessWidget {
  const CadastroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Usuário',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3157A4)),
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFD9DFEA)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFD9DFEA)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF3157A4), width: 1.6),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, width: 1.6),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 17,
          ),
        ),
      ),
      home: const CadastroPage(),
    );
  }
}

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();
  bool _mostrarSenha = false;

  String? _validarNome(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Digite seu nome completo';
    }
    if (value.trim().split(RegExp(r'\s+')).length < 2) {
      return 'Informe nome e sobrenome';
    }
    return null;
  }

  String? _validarEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Digite seu e-mail';
    }
    if (!value.contains('@')) {
      return 'Digite um e-mail válido';
    }
    return null;
  }

  String? _validarCpf(String? value) {
    if (value == null || value.isEmpty) {
      return 'Digite seu CPF';
    }
    if (value.length != 11) {
      return 'O CPF deve conter 11 números';
    }
    return null;
  }

  String? _validarTelefone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Digite seu telefone';
    }
    if (value.length != 10 && value.length != 11) {
      return 'Informe um telefone com DDD (10 ou 11 números)';
    }
    return null;
  }

  String? _validarSenha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Digite uma senha';
    }
    if (value.length < 6) {
      return 'A senha deve possuir pelo menos 6 caracteres';
    }
    return null;
  }

  void _cadastrar() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Cadastro realizado com sucesso!'),
            backgroundColor: Color(0xFF247A4B),
            duration: Duration(seconds: 3),
          ),
        );
    }
  }

  Widget _campo({
    required String label,
    required String hint,
    required IconData icon,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    bool obscureText = false,
    Widget? suffixIcon,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return TextFormField(
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      textCapitalization: textCapitalization,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        suffixIcon: suffixIcon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Formulário de Cadastro',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Card(
                color: Colors.white,
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: Color(0xFFE6EAF1)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Icon(
                          Icons.person_add_alt_1_rounded,
                          size: 42,
                          color: Color(0xFF3157A4),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Crie sua conta',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Preencha os campos abaixo para realizar seu cadastro.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xFF667085)),
                        ),
                        const SizedBox(height: 28),
                        _campo(
                          label: 'Nome completo',
                          hint: 'Digite seu nome e sobrenome',
                          icon: Icons.person_outline,
                          validator: _validarNome,
                          textCapitalization: TextCapitalization.words,
                        ),
                        const SizedBox(height: 16),
                        _campo(
                          label: 'E-mail',
                          hint: 'exemplo@email.com',
                          icon: Icons.email_outlined,
                          validator: _validarEmail,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),
                        _campo(
                          label: 'CPF',
                          hint: 'Somente números',
                          icon: Icons.badge_outlined,
                          validator: _validarCpf,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(11),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _campo(
                          label: 'Telefone',
                          hint: 'DDD + número',
                          icon: Icons.phone_outlined,
                          validator: _validarTelefone,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(11),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _campo(
                          label: 'Senha',
                          hint: 'Mínimo de 6 caracteres',
                          icon: Icons.lock_outline,
                          validator: _validarSenha,
                          obscureText: !_mostrarSenha,
                          suffixIcon: IconButton(
                            tooltip: _mostrarSenha ? 'Ocultar senha' : 'Mostrar senha',
                            onPressed: () {
                              setState(() => _mostrarSenha = !_mostrarSenha);
                            },
                            icon: Icon(
                              _mostrarSenha
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          height: 52,
                          child: ElevatedButton(
                            onPressed: _cadastrar,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3157A4),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'CADASTRAR',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Atividade acadêmica — Formulários e Validações no Flutter',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF98A2B3),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
