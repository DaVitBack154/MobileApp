// import 'package:flutter/material.dart';

// class dropdownButtonFormField extends StatefulWidget {
//   final List<String> valueList;
//   final Color borderColor;
//   final Color? prefixiconColor;
//   final Widget? prefixicon;
//   final Color? iconColor;
//   final Widget? icon;
//   final EdgeInsets contentPadding;
//   final double width;
//   final String hintText;
//   final Color hintColor;
//   final Color valueColor;
//   final EdgeInsets padding;
//   final bool enable;
//   const dropdownButtonFormField({
//     Key? key,
//     required this.valueList,
//     this.width = 200,
//     this.borderColor = const Color(0xFFE6E6E6),
//     this.prefixiconColor = const Color(0xFF4375F6),
//     this.prefixicon,
//     this.iconColor = const Color(0xFF4375F6),
//     this.icon,
//     this.contentPadding = const EdgeInsets.all(0),
//     this.hintText = '',
//     this.hintColor = const Color(0xFF747474),
//     this.valueColor = const Color(0xFF384348),
//     this.padding = const EdgeInsets.all(0),
//     this.enable = true,
//   }) : super(key: key);

//   @override
//   State<dropdownButtonFormField> createState() =>
//       _dropdownButtonFormFieldState();
// }

// class _dropdownButtonFormFieldState extends State<dropdownButtonFormField> {
//   String? dropdownValue;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: widget.padding,
//       child: Align(
//         alignment: Alignment.centerLeft,
//         child: SizedBox(
//           width: widget.width,
//           //height: 58,
//           child: DropdownButtonFormField<String>(
//             decoration: InputDecoration(
//               enabled: widget.enable,
//               filled: true,
//               fillColor: widget.borderColor,
//               prefixIcon: widget.prefixicon,
//               prefixIconColor: widget.prefixiconColor,
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: BorderSide(color: widget.borderColor),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: BorderSide(color: widget.borderColor),
//               ),
//               disabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: BorderSide(color: widget.borderColor),
//               ),
//               contentPadding: widget.contentPadding,
//             ),
//             icon: widget.icon,
//             iconEnabledColor: widget.iconColor,
//             iconSize: 30,
//             hint: Text(
//               widget.hintText,
//               style: TextStyle(
//                   fontSize: 18,
//                   color: widget.hintColor,
//                   fontWeight: FontWeight.w500),
//             ),
//             value: dropdownValue,
//             items: widget.valueList.map<DropdownMenuItem<String>>(
//               (String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(
//                     value,
//                     style: TextStyle(
//                         //fontFamily: 'Inter',
//                         fontSize: 18,
//                         color: widget.valueColor,
//                         fontWeight: FontWeight.w500),
//                   ),
//                 );
//               },
//             ).toList(),
//             onChanged: widget.enable
//                 ? (String? value) {
//                     // This is called when the user selects an item.
//                     setState(() {
//                       dropdownValue = value!;
//                     });
//                   }
//                 : null,
//           ),
//         ),
//       ),
//     );
//   }
// }
