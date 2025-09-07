// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:moviee_app/theme/app_colors.dart';
// import 'package:moviee_app/theme/app_text_style.dart';
// import 'package:moviee_app/models/category_model.dart';

// class BuildSearchField extends StatefulWidget {
//   const BuildSearchField({
//     super.key,
//     required this.controller,
//     required this.onChanged,
//   });

//   final TextEditingController controller;
//   final Function(String) onChanged;

//   @override
//   State<BuildSearchField> createState() => _BuildSearchFieldState();
// }

// class _BuildSearchFieldState extends State<BuildSearchField> {
//   List<CategoryModel> filterList = [];

//   // Search Method
//   void _searchFunction(String keyWord) {
//     setState(() {
//       if (keyWord.isEmpty) {
//         filterList = [];
//       } else {
//         filterList = CategoryModel.categories.where((product) {
//           final title = product.name.toString().toLowerCase();
//           final input = keyWord.toLowerCase();
//           return title.contains(input);
//         }).toList();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: SizedBox(
//         height: 55,
//         child: TextFormField(
//           onChanged: _searchFunction,
//           style: TextStyle(color: Colors.white),
//           controller: widget.controller,
//           cursorColor: Colors.white,
//           cursorHeight: 20,
//           decoration: InputDecoration(
//             hint: AppText("Search", fontSize: 16, color: AppColors.kIconColor),
//             prefixIcon: Icon(
//               CupertinoIcons.search,
//               size: 20,
//               color: AppColors.kIconColor,
//             ),
//             suffixIcon:
//                 widget.controller.text != "" &&
//                     widget.controller.text.isNotEmpty
//                 ? GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         widget.controller.text = "";
//                         _searchFunction("");
//                       });
//                     },
//                     child: Icon(
//                       CupertinoIcons.clear,
//                       size: 20,
//                       color: AppColors.kIconColor,
//                     ),
//                   )
//                 : SizedBox.shrink(),
//             filled: true,
//             fillColor: AppColors.kTextFieldColor,
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(color: AppColors.kTextFieldColor),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(color: AppColors.kTextFieldColor),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
