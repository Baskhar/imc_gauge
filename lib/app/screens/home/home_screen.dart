import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'home_controller.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  IMCController imcController = IMCController();
  final _formKey = GlobalKey<FormState>();
  final _peso = TextEditingController();
  final _altura = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: Text('IMC Calculator'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _peso,
                        keyboardType: TextInputType.number,
                        inputFormatters: [

                          TextInputFormatter.withFunction((oldValue, newValue) {
                            return TextEditingValue(
                              text: newValue.text.replaceFirst(',', '.'),
                              selection: newValue.selection,
                            );
                          }),
                        ],
                        decoration: InputDecoration(
                          labelText: 'Peso (kg)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira o peso';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _altura,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [

                          TextInputFormatter.withFunction((oldValue, newValue) {
                            return TextEditingValue(
                              text: newValue.text.replaceFirst(',', '.'),
                              selection: newValue.selection,
                            );
                          }),
                        ],
                        decoration: InputDecoration(
                          labelText: 'Altura (m)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira a altura';
                          }
                          return null;
                        },
                      ),



                      SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity, // Largura de tela
                        height: 50, // Altura do botão
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              imcController.weight = double.tryParse(_peso.text) ?? 0.0;
                              imcController.height = double.tryParse(_altura.text) ?? 0.0;
                              imcController.calculateIMC();
                              setState(() {}); // Atualizar a tela com o resultado e o gauge
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black, // Altere a cor do botão aqui
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // Adicione bordas arredondadas aqui
                              side: BorderSide(color: Colors.blue), // Adicione uma borda se desejar
                            ),
                          ),
                          child: Text(
                            'Calcular',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white, // Cor do texto
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 20),
                SfRadialGauge(
                  axes: <RadialAxis>[
                    RadialAxis(
                      minimum: 10,
                      maximum: 50,
                      showLabels: false,
                      showTicks: false,
                      axisLineStyle: AxisLineStyle(
                        thickness: 0.2,
                        color: Color.fromARGB(30, 0, 169, 181),
                        thicknessUnit: GaugeSizeUnit.factor,
                      ),
                      ranges: <GaugeRange>[
                        GaugeRange(
                          startValue: 10,
                          endValue: 18.4,
                          color: Colors.yellow,
                        ),
                        GaugeRange(
                          startValue: 18.5,
                          endValue: 24.9,
                          color: Colors.green,
                        ),
                        GaugeRange(
                          startValue: 25.0,
                          endValue: 29.9,
                          color: Colors.orange,
                        ),
                        GaugeRange(
                          startValue: 30.0,
                          endValue: 34.9, // Ajuste este valor de acordo com seu intervalo
                          color: Colors.red,
                        ),
                        GaugeRange(
                          startValue: 35.0, // Ajuste este valor de acordo com seu intervalo
                          endValue: 39.9, // Ajuste este valor de acordo com seu intervalo
                          color: Colors.purple,
                        ),
                        GaugeRange(
                          startValue: 40.0, // Ajuste este valor de acordo com seu intervalo
                          endValue: 50.0, // Ajuste este valor de acordo com seu intervalo
                          color: Colors.red,
                        ),
                      ],
                      pointers: <GaugePointer>[
                        NeedlePointer(
                          value: imcController.result,
                          enableAnimation: true,
                          animationDuration: 1000,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'IMC: ${imcController.result.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  'Classificação: ${imcController.getIMCClassification()}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 5),
                Text(
                  imcController.calculateWeightChangeToNormal(),
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
