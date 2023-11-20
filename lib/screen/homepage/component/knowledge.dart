// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mobile_chaseapp/controller/getpromotion.dart';
// import 'package:mobile_chaseapp/model/respon_promotion.dart';
// import 'package:mobile_chaseapp/screen/homepage/component/imgnetwork.dart';
// import 'package:mobile_chaseapp/screen/homepage/promotion/knowledge_content_lang.dart';

// class Knowled extends StatefulWidget {
//   const Knowled({super.key});

//   @override
//   State<Knowled> createState() => _KnowledState();
// }

// class _KnowledState extends State<Knowled> {
//   // PromotionController promotionController = PromotionController();

//   bool loading = true;
//   // String imageUrl = ImageNetwork.url;

//   // Future<void> fetchPromotion() async {
//   //   setState(() {
//   //     loading = true;
//   //   });
//   //   try {
//   //     await promotionController.fetchPromotion();
//   //     loading = false;
//   //     setState(() {});
//   //   } catch (error) {
//   //     print('เกิดข้อผิดพลาดในการดึงข้อมูล: $error');
//   //   }
//   // }

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   fetchPromotion();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return loading
//         ? const SizedBox()
//         : Column(
//             children: [
//               Text('ซื้อ-ขายบ้าน')
//               Padding(
//                 padding: const EdgeInsets.only(
//                   top: 15,
//                   left: 15,
//                   right: 15,
//                   bottom: 5,
//                 ).h,
//                 child: SizedBox(
//                   width: double.infinity,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'ซื้อขายบ้าน',
//                         style: TextStyle(
//                           fontSize: 23.sp,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                       const SizedBox()
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 child: Column(
//                   children: [
//                     ...List.generate(
//                         promotionController.userpromotion.data?.length ?? 0,
//                         (index) {
//                       Datum data =
//                           promotionController.userpromotion.data![index];
//                       if (data?.typeImage == 'image_lang' &&
//                           data?.status == 'ON') {
//                         return InkWell(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => PromotionLang(
//                                   item: data,
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Padding(
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: 5.w,
//                                 vertical: 3.h,
//                               ),
//                               child: Card(
//                                 clipBehavior: Clip.antiAlias,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(15),
//                                 ),
//                                 elevation: 3,
//                                 child: Row(
//                                   children: [
//                                     Image.network(
//                                       '$imageUrl/public/image/${data.image}',
//                                       width: 130,
//                                       fit: BoxFit.cover,
//                                     ),
//                                     Expanded(
//                                       child: Padding(
//                                         padding: EdgeInsets.symmetric(
//                                           horizontal: 10.w,
//                                         ),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               data?.titlePro ?? 'รอดำเนินการ',
//                                               style: TextStyle(
//                                                 fontSize: 15.sp,
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               height: 10.h,
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Text(
//                                                   '14/09/2023',
//                                                   style: TextStyle(
//                                                     fontSize: 16.sp,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),),
                        
//                         );
//                       }

//                       return const SizedBox.shrink();
//                     }).toList(),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 10.h,
//               ),
//             ],
//           );
//   }
// }
