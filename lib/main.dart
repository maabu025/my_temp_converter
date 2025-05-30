import 'package:flutter/material.dart';
import 'widgets/conversion_tile.dart';

void main() => runApp(TempConverterApp());

class TempConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      debugShowCheckedModeBanner: false,
      home: TempConverterScreen(),
    );
  }
}

class TempConverterScreen extends StatefulWidget {
  @override
  _TempConverterScreenState createState() => _TempConverterScreenState();
}

enum ConversionType { fToC, cToF }

class _TempConverterScreenState extends State<TempConverterScreen> {
  final TextEditingController _controller = TextEditingController();
  ConversionType _conversionType = ConversionType.fToC;
  String _result = '';
  List<String> _history = [];

  void _convert() {
    final input = double.tryParse(_controller.text);
    if (input == null) return;

    double output;
    String record;

    if (_conversionType == ConversionType.fToC) {
      output = (input - 32) * 5 / 9;
      record = 'F to C: ${input.toStringAsFixed(1)} => ${output.toStringAsFixed(2)}';
    } else {
      output = input * 9 / 5 + 32;
      record = 'C to F: ${input.toStringAsFixed(1)} => ${output.toStringAsFixed(2)}';
    }

    setState(() {
      _result = output.toStringAsFixed(2);
      _history.insert(0, record);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Temperature Converter')),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Enter Temperature',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text('Fahrenheit to Celsius'),
                        leading: Radio<ConversionType>(
                          value: ConversionType.fToC,
                          groupValue: _conversionType,
                          onChanged: (val) {
                            setState(() {
                              _conversionType = val!;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text('Celsius to Fahrenheit'),
                        leading: Radio<ConversionType>(
                          value: ConversionType.cToF,
                          groupValue: _conversionType,
                          onChanged: (val) {
                            setState(() {
                              _conversionType = val!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: _convert,
                  child: const Text('Convert'),
                ),
                const SizedBox(height: 16),
                Text('Result: $_result', style: const TextStyle(fontSize: 20)),
                const Divider(),
                const Text('Conversion History:', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                ..._history.map((entry) => ConversionTile(entry)),
              ],
            ),
          );
        },
      ),
    );
  }
}
