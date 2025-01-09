import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:forms/SecondScreen.dart';

class FormData {
  final String manufacturer;
  final String country;
  final int year;
  final String company;
  final int weight;
  final int maxVoltage;
  final int nominalPower;
  final int nominalVoltage;
  final int nominalCurrent;
  final double efficiency;

  FormData({
    required this.manufacturer,
    required this.country,
    required this.year,
    required this.company,
    required this.weight,
    required this.maxVoltage,
    required this.nominalPower,
    required this.nominalVoltage,
    required this.nominalCurrent,
    required this.efficiency,
  });
}

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  void _onSubmit() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formData = _formKey.currentState!.value;
      debugPrint('Form Data on First Screen: $formData');

      final data = FormData(
        manufacturer: formData['manufacturer'],
        country: formData['country'],
        year: int.tryParse(formData['year']) ?? 0,
        company: formData['company'],
        weight: int.tryParse(formData['weight']) ?? 0,
        maxVoltage: int.tryParse(formData['maxVoltage']) ?? 0,
        nominalPower: int.tryParse(formData['nominalPower']) ?? 0,
        nominalVoltage: int.tryParse(formData['nominalVoltage']) ?? 0,
        nominalCurrent: int.tryParse(formData['nominalCurrent']) ?? 0,
        efficiency: formData['efficiency'] ?? 50.0,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SecondScreen(formData: data),
        ),
      );
    }
  }

  InputDecoration _buildInputDecoration(String label, [String? hint]) {
    return InputDecoration(
      labelText: label,
      hintText: hint ?? '',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      filled: true,
      fillColor: Colors.grey[50],
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      labelStyle: TextStyle(color: Colors.blue[800]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Module Information Form'),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[50] ?? Colors.blue, Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildModuleInfoCard(),
                const SizedBox(height: 16),
                _buildTechnicalSpecsCard(),
                const SizedBox(height: 16),
                _buildEfficiencyCard(),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _onSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[800],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModuleInfoCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            FormBuilderTextField(
              name: 'manufacturer',
              decoration: _buildInputDecoration(
                  'Module Manufacturer', 'Enter manufacturer name'),
              validator: FormBuilderValidators.required(),
            ),
            const SizedBox(height: 16),
            FormBuilderTextField(
              name: 'country',
              decoration: _buildInputDecoration(
                  'Manufacturing Country', 'Enter country name'),
              validator: FormBuilderValidators.required(),
            ),
            const SizedBox(height: 16),
            FormBuilderTextField(
              name: 'year',
              decoration: _buildInputDecoration('Manufacturing Year', 'YYYY'),
              keyboardType: TextInputType.number,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.numeric(),
                FormBuilderValidators.min(1900),
                FormBuilderValidators.max(DateTime.now().year),
              ]),
            ),
            const SizedBox(height: 16),
            FormBuilderDropdown(
              name: 'company',
              decoration: _buildInputDecoration('Electrical Company'),
              items: ['LECO', 'CEB']
                  .map((company) => DropdownMenuItem(
                        value: company,
                        child: Text(company),
                      ))
                  .toList(),
              validator: FormBuilderValidators.required(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTechnicalSpecsCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Technical Specifications',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildNumericField('weight', 'Module Weight (kg)', 'Enter weight'),
            const SizedBox(height: 16),
            _buildNumericField(
                'maxVoltage', 'Max System Voltage (V)', 'Enter voltage'),
            const SizedBox(height: 16),
            _buildNumericField(
                'nominalPower', 'Nominal Power (W)', 'Enter power'),
            const SizedBox(height: 16),
            _buildNumericField(
                'nominalVoltage', 'Nominal Voltage (V)', 'Enter voltage'),
            const SizedBox(height: 16),
            _buildNumericField(
                'nominalCurrent', 'Nominal Current (A)', 'Enter current'),
          ],
        ),
      ),
    );
  }

  Widget _buildEfficiencyCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Efficiency Rating',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            FormBuilderSlider(
              name: 'efficiency',
              min: 1,
              max: 100,
              initialValue: 50.0,
              divisions: 99,
              decoration: const InputDecoration(
                labelText: 'Module Efficiency (%)',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumericField(String name, String label, String hint) {
    return FormBuilderTextField(
      name: name,
      decoration: _buildInputDecoration(label, hint),
      keyboardType: TextInputType.number,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.numeric(),
      ]),
    );
  }
}
