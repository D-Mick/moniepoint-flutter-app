// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:stockrx/shared/res/app_colors.dart';
//
// class StockrxDropDown extends StatelessWidget {
//   const StockrxDropDown({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 830.w,
//       padding: const EdgeInsets.symmetric(
//         horizontal: 10.0,
//       ),
//       decoration: BoxDecoration(
//         border:
//         Border.all(color: AppColors.brandPrimaryColor),
//         color: Colors.white,
//       ),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<String>(
//           value: selectedValue ?? '1',
//           dropdownColor: AppColors.white,
//           icon: const Icon(Icons.arrow_drop_down, color: AppColors.brandPrimaryColor,),
//           iconSize: 20,
//           style: const TextStyle(color: AppColors.brandPrimaryColor),
//           onChanged: onItemSelected,
//           items: dropdownItems
//               .map<DropdownMenuItem<String>>(
//                   (String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//         ),
//       ),
//     );
//   }
// }
