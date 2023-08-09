import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  Home({super.key});

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
    weightController.text = '';
    heightController.text = '';
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
      if (imc < 18.6)
        _infoText = 'Abaixo do peso';
      else if (imc >= 18.6 && imc < 24.9)
        _infoText = 'Peso ideal';
      else if (imc >= 24.9 && imc < 29.9)
        _infoText = 'Levemente acima do peso';
      else if (imc >= 29.9 && imc < 34.9)
        _infoText = 'Obesidade - Grau I';
      else if (imc >= 34.9 && imc < 39.9)
        _infoText = 'Obesidade - Grau II';
      else if (imc >= 40) _infoText = 'Obesidade - Grau III';
      _infoText += ' (${imc.toStringAsFixed(2)})';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(onPressed: _resetFields, icon: Icon(Icons.refresh)),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.person_sharp,
                size: 120,
                color: Colors.green,
              ),
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 2,
                    ),
                  ),
                  labelText: 'Peso',
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 20),
                  suffix: Text('kg', style: TextStyle(color: Colors.grey)),
                  errorText: weightErrorMessage,
                ),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 2,
                    ),
                  ),
                  labelText: 'Altura',
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 20),
                  suffix: Text('cm', style: TextStyle(color: Colors.grey)),
                  errorText: heightErrorMessage,
                ),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Container(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _calculate,
                    child: Text(
                      'Calcular',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
