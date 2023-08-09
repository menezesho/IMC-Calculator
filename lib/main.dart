import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  String _infoText = '';
  String? weightErrorMessage;
  String? heightErrorMessage;

  void _resetFields() {
    weightErrorMessage = heightErrorMessage = null;
    weightController.clear();
    heightController.clear();
    setState(() {
      _infoText = '';
    });
  }

  void _calculate() {
    bool emptyField = false;
    weightErrorMessage = heightErrorMessage = null;
    if (weightController.text.isEmpty) {
      setState(() {
        weightErrorMessage = 'Informe o peso!';
      });
      emptyField = true;
    }
    if (heightController.text.isEmpty) {
      setState(() {
        heightErrorMessage = 'Informe a altura!';
      });
      emptyField = true;
    }
    if (emptyField) return;
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;
    double imc = weight / (height * height);
    setState(() {
      if (imc < 18.6) {
        _infoText = 'Abaixo do peso';
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = 'Peso ideal';
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = 'Levemente acima do peso';
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = 'Obesidade - Grau I';
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = 'Obesidade - Grau II';
      } else if (imc >= 40) {
        _infoText = 'Obesidade - Grau III';
      }
      _infoText += ' (${imc.toStringAsFixed(2)})';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(onPressed: _resetFields, icon: const Icon(Icons.refresh)),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Icon(
                  Icons.person_sharp,
                  size: 120,
                  color: Colors.green,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: weightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green,
                            width: 2,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green,
                            width: 2,
                          ),
                        ),
                        labelText: 'Peso',
                        labelStyle: const TextStyle(color: Colors.grey, fontSize: 20),
                        suffix: const Text('kg', style: TextStyle(color: Colors.grey)),
                        errorText: weightErrorMessage,
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16), // Add spacing between the text fields
                  Expanded(
                    child: TextField(
                      controller: heightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green,
                            width: 2,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green,
                            width: 2,
                          ),
                        ),
                        labelText: 'Altura',
                        labelStyle: const TextStyle(color: Colors.grey, fontSize: 20),
                        suffix: const Text('cm', style: TextStyle(color: Colors.grey)),
                        errorText: heightErrorMessage,
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _calculate,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    child: const Text(
                      'Calcular',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
