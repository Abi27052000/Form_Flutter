import 'package:flutter/material.dart';
import 'package:forms/FormScreen.dart.dart';

class SecondScreen extends StatelessWidget {
  final FormData formData;

  const SecondScreen({Key? key, required this.formData}) : super(key: key);

  Widget _buildInfoCard(String title, String value) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.blue[800],
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Form Data on Second Screen: $formData');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Data Review'),
        backgroundColor: Colors.blue[800],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildInfoCard('Manufacturer', formData.manufacturer),
            _buildInfoCard('Country', formData.country),
            _buildInfoCard('Year', formData.year.toString()),
            _buildInfoCard('Company', formData.company),
            _buildInfoCard('Weight', '${formData.weight} kg'),
            _buildInfoCard('Max Voltage', '${formData.maxVoltage} V'),
            _buildInfoCard('Nominal Power', '${formData.nominalPower} W'),
            _buildInfoCard('Nominal Voltage', '${formData.nominalVoltage} V'),
            _buildInfoCard('Nominal Current', '${formData.nominalCurrent} A'),
            _buildInfoCard(
                'Efficiency', '${formData.efficiency.toStringAsFixed(1)}%'),
          ],
        ),
      ),
    );
  }
}
