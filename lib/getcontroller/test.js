// GroupedListView<dynamic, String>(
//   reverse: true,
//   floatingHeader: true,
//   order: GroupedListOrder.DESC,
//   elements: filteredMessages,
//   groupBy: (element) => element.createdAt,
//   padding: const EdgeInsets.only(top: 16),
//   itemBuilder: (context, element) {
//     int index = filteredMessages.indexOf(element);
//     return chatList(element, index);
//   },
//   groupHeaderBuilder: (element) {
//     int index = filteredMessages.indexOf(element);
//     ChatMessage message = element;
//     ChatMessage? nextMessage;
//     if (index != 0) {
//       nextMessage = filteredMessages[index - 1];
//     }
//     if (nextMessage != null) {
//       DateTime dateTime1 =
//           DateTime.parse(message.createdAt ?? "");
//       DateTime dateTime2 =
//           DateTime.parse(nextMessage.createdAt ?? "");
//       int diff = dateTime2.difference(dateTime1).inDays;
//       if (diff == 0) return const SizedBox.shrink();
//     }

//     DateTime dateTime = DateTime.parse(element.createdAt);
//     String dateFormat =
//         DateFormat("dd/MM/yyyy").format(dateTime);

//     return Center(
//       child: Text(dateFormat),
//     );
//   },
//   // groupStickyHeaderBuilder: (element) {
//   //   return Text("22222");
//   // },
//   // groupItemBuilder:
//   //     (context, element, groupStart, groupEnd) {
//   //   return Text(
//   //       "groupStart $groupStart : groupEnd $groupEnd");
//   // },

//   groupSeparatorBuilder: (value) {
//     DateTime dateTime = DateTime.parse(value);
//     String dateFormat =
//         DateFormat("dd/MM/yyyy").format(dateTime);
//     return Center(
//       child: Text(dateFormat),
//     );
//   },
// );

///แยก

// Future<void> sendMessageWithImages() async {
//   try {
//     List<String> imageUrls = [];

//     // อัพโหลดภาพหากมีภาพที่เลือก
//     if (selectedImages.isNotEmpty) {
//       imageUrls = await uploadImages(selectedImages);
//     }

//     // สร้างข้อความ
//     final message = ChatMessage(
//       sender: name.value,
//       message: messageController.value.text,
//       receiver: 'admin',
//       statusRead: 'SU',
//       statusConnect: 'N',
//       idCard: idcard.value,
//       role: 'user',
//       image: imageUrls,
//     );

//     // ส่งข้อความ
//     await sendMessage(message);

//     // เคลียร์ข้อมูล
//     messageController.value.clear();
//     selectedImages.clear();
//   } catch (e) {
//     print('Error sending message with images: $e');
//   }
// }

//ส่วนการ์ด
// Card(
//     clipBehavior: Clip.antiAlias,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(20),
//     ),
//     elevation: 2,
//     child: Container(
//       decoration: const BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage('assets/image/bgcard.png'),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: Padding(
//         padding: EdgeInsets.symmetric(
//           vertical: 15.h,
//           horizontal: 10.w,
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               width: double.infinity,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   data.companyId == 'RWAY'
//                       ? Column(
//                           crossAxisAlignment:
//                               CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Resolution Way Co., Ltd.',
//                               style: TextStyle(
//                                 fontSize: 15.sp,
//                                 fontWeight: FontWeight.normal,
//                                 height: 0.06,
//                                 color: Color(0xFF5C5C5C),
//                                 //color: Colors.grey.shade600,
//                               ),
//                             ),
//                             SizedBox(
//                               height: 5.h,
//                             ),
//                             Text(
//                               'บริษัท รีโซลูชั่น เวย์ จำกัด',
//                               style: TextStyle(
//                                 fontSize: 15.sp,
//                                 fontWeight: FontWeight.normal,
//                                 color: Color(0xFF5C5C5C),
//                               ),
//                             ),
//                           ],
//                         )
//                       : data.companyId == 'CFAA'
//                           ? Column(
//                               crossAxisAlignment:
//                                   CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'CF Asia Asset Management Co., Ltd.',
//                                   style: TextStyle(
//                                     fontSize: 15.sp,
//                                     fontWeight: FontWeight.normal,
//                                     height: 0.06,
//                                     color: Color(0xFF5C5C5C),
//                                     //color: Colors.grey.shade600,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 5.h,
//                                 ),
//                                 Text(
//                                   'บริษัท บริหารสินทรัพย์ ซีเอฟ เอเชีย จำกัด',
//                                   style: TextStyle(
//                                     fontSize: 15.sp,
//                                     fontWeight: FontWeight.normal,
//                                     color: Color(0xFF5C5C5C),
//                                   ),
//                                 ),
//                               ],
//                             )
//                           : Column(
//                               crossAxisAlignment:
//                                   CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Courts Megastore (Thailand) Co., Ltd.',
//                                   style: TextStyle(
//                                     fontSize: 15.sp,
//                                     fontWeight: FontWeight.normal,
//                                     height: 0.06,
//                                     color: Color(0xFF5C5C5C),
//                                     //color: Colors.grey.shade600,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 5.h,
//                                 ),
//                                 Text(
//                                   'บริษัท คอร์ทส์ เม็กก้าสโตร์ (ประเทศไทย) จำกัด',
//                                   style: TextStyle(
//                                     fontSize: 15.sp,
//                                     fontWeight: FontWeight.normal,
//                                     color: Color(0xFF5C5C5C),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                   Column(
//                     children: [
//                       data.companyId == 'RWAY' ||
//                               data.companyId == 'CFAA'
//                           ? Image.asset(
//                               'assets/image/${data.companyId == 'CFAA' || data.companyId == 'CFAM' ? 'cfam.png' : data.companyId == 'RWAY' ? 'rway.png' : 'courts.png'}',
//                               height:
//                                   MyConstant.setMediaQueryWidth(
//                                       context, 20),
//                               fit: BoxFit.cover,
//                             )
//                           : Image.asset(
//                               'assets/image/${data.companyId == 'CFAA' || data.companyId == 'CFAM' ? 'cfam.png' : data.companyId == 'RWAY' ? 'rway.png' : 'courts.png'}',
//                               height:
//                                   MyConstant.setMediaQueryWidth(
//                                       context, 17),
//                               fit: BoxFit.cover,
//                             ),
//                       SizedBox(
//                         height: 20.h,
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 7.h,
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'ภาระหนี้คงเหลือ (บาท)',
//                   style: TextStyle(
//                     fontWeight: FontWeight.normal,
//                     fontSize: 19.sp,
//                     height: 1.2,
//                     color: Colors.black,
//                   ),
//                 ),
//                 data.flagCode == 'CLS' || data.flagCode == 'CLSW'
//                     ? Text(
//                         '(ปิดบัญชีแล้ว)',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18.sp,
//                             height: 1.2,
//                             color: Colors.teal.shade500),
//                       )
//                     : data.legalType == 'ยังไม่ได้ฟ้อง' &&
//                             (data.calType == 'D' ||
//                                 data.calType == 'K')
//                         ? Column(
//                             children: [
//                               Text(
//                                 data.osBalance != null
//                                     ? formatCurrency(
//                                         data.osBalance)
//                                     : '',
//                                 style: TextStyle(
//                                   fontSize: MyConstant
//                                       .setMediaQueryWidth(
//                                           context, 30),
//                                   fontWeight: FontWeight.bold,
//                                   height: 1.2,
//                                   color: const Color(0xFF103533),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 5.h,
//                               ),
//                             ],
//                           )
//                         : data.calType == '' ||
//                                 data.calType == null
//                             ? Column(
//                                 children: [
//                                   Text(
//                                     'กรุณาติดต่อเจ้าหน้าที่เพื่อตรวจสอบยอดหนี้คงค้าง',
//                                     style: TextStyle(
//                                       fontSize: MyConstant
//                                           .setMediaQueryWidth(
//                                               context, 19),
//                                       fontWeight: FontWeight.bold,
//                                       height: 1.3,
//                                       // color: const Color(0xFF103533),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 5.h,
//                                   ),
//                                 ],
//                               )
//                             : data.legalType ==
//                                         'ฟ้องแล้วยังไม่พิพากษา' ||
//                                     data.legalType ==
//                                         'พิพากษาแล้วยังไม่ยืนยัน'
//                                 ? Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         data.lawsuiteAmount !=
//                                                 null
//                                             ? formatCurrency(data
//                                                 .lawsuiteAmount!)
//                                             : '',
//                                         style: TextStyle(
//                                           fontSize: MyConstant
//                                               .setMediaQueryWidth(
//                                                   context, 25),
//                                           fontWeight:
//                                               FontWeight.bold,
//                                           height: 1.2,
//                                           color: const Color(
//                                               0xFF103533),
//                                         ),
//                                       ),
//                                       Text(
//                                         'ยอดหนี้ ณ วันที่ ${formattedDate.format(
//                                           DateTime.parse(data
//                                               .lawsuiteDate
//                                               .toString()),
//                                         )} ',
//                                         style: TextStyle(
//                                           fontSize: MyConstant
//                                               .setMediaQueryWidth(
//                                                   context, 17),
//                                           height: 1.2,
//                                           color: const Color(
//                                               0xFF103533),
//                                         ),
//                                       ),
//                                       Text(
//                                         'กรุณาติดต่อเจ้าหน้าที่เพื่อตรวจสอบยอดหนี้คงค้าง',
//                                         style: TextStyle(
//                                           fontSize: MyConstant
//                                               .setMediaQueryWidth(
//                                                   context, 17),
//                                           height: 1.2,
//                                           color: const Color(
//                                               0xFF103533),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: 5.h,
//                                       )
//                                     ],
//                                   )
//                                 : data.legalType ==
//                                         'ยืนยันคำพิพากษาแล้ว'
//                                     ? Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment
//                                                 .start,
//                                         children: [
//                                           Text(
//                                             data.osBalance != null
//                                                 ? formatCurrency(
//                                                     data.osBalance)
//                                                 : '',
//                                             style: TextStyle(
//                                               fontSize: MyConstant
//                                                   .setMediaQueryWidth(
//                                                       context,
//                                                       25),
//                                               fontWeight:
//                                                   FontWeight.bold,
//                                               height: 1.2,
//                                               color: const Color(
//                                                   0xFF103533),
//                                             ),
//                                           ),
//                                           Text(
//                                             'ยอดหนี้ ณ วันที่ ${formattedDate.format(
//                                               DateTime.parse(data
//                                                   .reportAsOf
//                                                   .toString()),
//                                             )} ',
//                                             style: TextStyle(
//                                               fontSize: MyConstant
//                                                   .setMediaQueryWidth(
//                                                       context,
//                                                       17),
//                                               height: 1.0,
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             height: 5.h,
//                                           )
//                                         ],
//                                       )
//                                     : SizedBox()
//               ],
//             ),
//             Row(
//               children: [
//                 Text(
//                   'Name :',
//                   style: TextStyle(
//                     color: Color(0xFF8A8A8A),
//                     fontSize: 18.sp,
//                     height: 1.2,
//                     fontWeight: FontWeight.normal,
//                   ),
//                 ),
//                 SizedBox(
//                   width: 5.w,
//                 ),
//                 Text(
//                   '${data.tCustomerName} ${data.tCustomerSurname}',
//                   style: TextStyle(
//                     overflow: TextOverflow.ellipsis,
//                     fontWeight: FontWeight.normal,
//                     fontSize: 18.sp,
//                     height: 1.2,
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 Text(
//                   '${data.customerId}',
//                   style: TextStyle(
//                     fontWeight: FontWeight.normal,
//                     fontSize: 18.sp,
//                     height: 1.2,
//                   ),
//                 ),
//                 // SizedBox(
//                 //   width: 10.w,
//                 // ),
//                 // data.flagCode == 'CLS' || data.flagCode == 'CLSW'
//                 //     ? Text(
//                 //         '(ปิดบัญชีแล้ว)',
//                 //         style: TextStyle(
//                 //             fontWeight: FontWeight.bold,
//                 //             fontSize: 18.sp,
//                 //             height: 1.2,
//                 //             color: Colors.blue.shade600),
//                 //       )
//                 //     : SizedBox.shrink()
//               ],
//             ),
//           ],
//         ),
//       ),
//     ),
//   ),
