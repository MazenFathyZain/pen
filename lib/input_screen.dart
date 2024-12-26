// import 'package:flutter/material.dart';
//
// class InputScreen extends StatefulWidget {
//   final String bpm;
//   final String breathingRate;
//   final String pressure;
//
//   const InputScreen({
//     super.key,
//     required this.bpm,
//     required this.breathingRate,
//     required this.pressure,
//   });
//
//   @override
//   _InputScreenState createState() => _InputScreenState();
// }
//
// class _InputScreenState extends State<InputScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _eventController = TextEditingController();
//   final TextEditingController _expectationController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "كتابة حدث",
//                   style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.teal),
//                 ),
//                 const SizedBox(height: 20),
//                 TextFormField(
//                   cursorColor: Colors.teal,
//                   controller: _eventController,
//                   decoration: const InputDecoration(
//                     labelText: "الحدث",
//                     hintText: "أدخل الحدث",
//                     prefixIcon: Icon(Icons.event, color: Colors.teal),
//                     labelStyle: TextStyle(color: Colors.black),
//                     // contentPadding: EdgeInsets.symmetric(
//                     // vertical: 40.0, horizontal: 10.0),
//                   ),
//                   validator: (value) =>
//                       value == null || value.isEmpty ? "برجاء إدخال حدث" : null,
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   cursorColor: Colors.teal,
//                   controller: _expectationController,
//                   decoration: const InputDecoration(
//                     labelText: "التوقع",
//                     hintText: "ماذا تتوقع؟",
//                     prefixIcon:
//                         Icon(Icons.lightbulb_outline, color: Colors.teal),
//                     labelStyle: TextStyle(color: Colors.black),
//                   ),
//                   validator: (value) => value == null || value.isEmpty
//                       ? "برجاء إدخال توقع"
//                       : null,
//                 ),
//                 const SizedBox(height: 20),
//                 _dataDisplayCard(
//                     widget.bpm, widget.breathingRate, widget.pressure),
//                 const SizedBox(height: 20),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: (){},
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       backgroundColor: Colors.teal,
//                     ),
//                     child: const Text(
//                       "حفظ",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _dataDisplayCard(String bpm, String breathingRate, String pressure) {
//     return Card(
//       color: Colors.white,
//       elevation: 10,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//       ),
//       margin: const EdgeInsets.all(16.0),
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               'بيانات القلم',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blueGrey[800],
//               ),
//             ),
//             const SizedBox(height: 20),
//             _dataRow('ضربات القلب', bpm),
//             _dataRow('معدل التنفس', breathingRate),
//             _dataRow('الضغط', pressure),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _dataRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//           ),
//           Text(
//             value,
//             style: const TextStyle(
//                 fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
//           ),
//         ],
//       ),
//     );
//   }
// }
