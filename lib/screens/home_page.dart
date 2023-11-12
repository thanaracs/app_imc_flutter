import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  late bool isMale;
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String bmiResult = '';

  @override
  void initState() {
    super.initState();
    isMale = true;
  }

  double calculateBMI(double weight, double height) {
    return weight / (height * height);
  }

  String interpretBMI(double bmi) {
    if (bmi < 18.5) {
      return 'Magreza leve';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return 'Saudável';
    } else if (bmi >= 25 && bmi < 29.9) {
      return 'Sobrepeso';
    } else {
      return 'Obesidade';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text('BMI Calculator'),
            SizedBox(width: 8),
            Tooltip(
              message: 'Menor que 18,5 – Magreza leve\n'
                  '18,5 a 24.9 – Saudável\n'
                  '25 a 29.9 – Sobrepeso\n'
                  'Maior que 30 – Obesidade',
              child: Icon(Icons.info),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isMale = true;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: isMale ? Colors.blue : Colors.transparent,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Column(
                    children: [
                      Icon(Icons.male, size: 50),
                      SizedBox(height: 8),
                      Text('Homem'),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isMale = false;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: !isMale ? Colors.pink : Colors.transparent,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Column(
                    children: [
                      Icon(Icons.female, size: 50),
                      SizedBox(height: 8),
                      Text('Mulher'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Peso (kg)',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Altura (ex: 1.78)',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              double? weight = double.tryParse(weightController.text);
              double? height = double.tryParse(heightController.text);

              if (weight == null ||
                  height == null ||
                  weight <= 0 ||
                  height <= 0) {
                setState(() {
                  bmiResult = 'Valores inválidos!';
                });
              } else {
                double bmi = calculateBMI(weight, height);
                String result = interpretBMI(bmi);

                setState(() {
                  bmiResult = 'IMC: ${bmi.toStringAsFixed(2)} - $result';
                });
              }
            },
            child: const Text('Calcule seu IMC'),
          ),
          const SizedBox(height: 16.0),
          Text(bmiResult),
        ],
      ),
    );
  }
}
