// import 'package:flutter/material.dart';

// class Document_Field extends StatefulWidget {
//   final String pathICon;
//   final String text;
//   const Document_Field({
//     Key? key,
//     required this.pathICon,
//     required this.text,
//   }) : super(key: key);

//   @override
//   State<Document_Field> createState() => _Document_FieldState();
// }

// class _Document_FieldState extends State<Document_Field> {
//   bool isChecked = false;

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     Color color = const Color(0xFF395D5D);

//     //double height = MediaQuery.of(context).size.height;
//     Color getColor(Set<MaterialState> states) {
//       const Set<MaterialState> interactiveStates = <MaterialState>{
//         MaterialState.pressed,
//         MaterialState.hovered,
//         MaterialState.focused,
//       };
//       if (states.any(interactiveStates.contains)) {
//         return Colors.grey.shade400;
//       }
//       return const Color(0xFF395D5D);
//     }

//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 200),
//       height: 92,
//       width: width - 40,
//       decoration: BoxDecoration(
//         color: Colors.transparent,
//         border: Border.all(
//             color: isChecked ? Colors.white : Colors.transparent, width: 1.2),
//         borderRadius: const BorderRadius.all(
//           Radius.circular(24),
//         ),
//       ),
//       alignment: Alignment.center,
//       child: GestureDetector(
//         onTap: () {
//           setState(() {
//             isChecked = !isChecked;
//           });
//           print('clicked');
//         },
//         child: Container(
//           height: 80,
//           width: width - 52,
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             //border: Border.all(color: Colors.transparent, width: 1.2),
//             borderRadius: BorderRadius.all(
//               Radius.circular(20),
//             ),
//           ),
//           child: Row(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 10, right: 10),
//                 child: Transform.scale(
//                   scale: 1.2,
//                   child: Checkbox(
//                     shape: const CircleBorder(),
//                     checkColor: Colors.white,
//                     fillColor: MaterialStateProperty.resolveWith(getColor),
//                     value: isChecked,
//                     onChanged: (bool? value) {
//                       setState(() {
//                         isChecked = value!;
//                       });
//                     },
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(right: 10),
//                 child: Image.asset(
//                   widget.pathICon,
//                   color: color,
//                   //scale: 1.5,
//                 ),
//               ),
//               Text(
//                 widget.text,
//                 style: TextStyle(
//                   color: color,
//                   fontWeight: FontWeight.w400,
//                   fontSize: 24,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
