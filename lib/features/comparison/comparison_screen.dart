import 'package:flutter/material.dart';
import 'package:smart_pen/core/constants.dart';

class ComparisonScreen extends StatelessWidget {
  const ComparisonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text("مقارنة مع توقعات السابقة"),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInputField('توقع بتاريخ'),
            _buildInputField('الشعور'),
            _buildInputField('معدل ضربات القلب'),
            _buildInputField('معدل التنفس'),
            _buildInputField('قوة الضغط'),
            _buildInputField('حالة التوقع'),
            _buildInputField('نسبه التقارب مع البيانات الحيوية الحديثة'),
            _buildInputField('احتمالية حالة التوقع الحديث'),
          ],
        ),
      ),
    );
  }

  // Helper method to build each input field
  Widget _buildInputField(String labelText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: secondColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8), // Rounded corners
            ),
          ),
        ],
      ),
    );
  }
  
}
