// import 'package:flutter/material.dart';
// import 'package:glowtap/glowtap/firebase/constant/appcolor.dart';
// import 'package:glowtap/glowtap/sql/preference/preference_handler.dart';
// import 'package:glowtap/glowtap/sql/views/education/educationdatapage.dart';
// import 'package:glowtap/glowtap/sql/views/education/educationdetailpage.dart';

// class FavoriteEducationPage extends StatefulWidget {
//   const FavoriteEducationPage({super.key});

//   @override
//   State<FavoriteEducationPage> createState() => _FavoriteEducationPageState();
// }

// class _FavoriteEducationPageState extends State<FavoriteEducationPage> {
//   List<String> savedTitles = [];

//   @override
//   void initState() {
//     super.initState();
//     load();
//   }

//   void load() async {
//     savedTitles = await PreferenceHandler.getFavoriteEducations();
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     final savedItems = educationList.where((e) => savedTitles.contains(e.title)).toList();

//     return Scaffold(
//       backgroundColor: Appcolor.softPinkPastel,
//       appBar: AppBar(
//         backgroundColor: Appcolor.button1,
//         title: const Text("Disimpan 💗", style: TextStyle(color: Colors.white)),
//       ),
//       body: savedItems.isEmpty
//           ? Center(child: Text("Belum ada edukasi yang disimpan", style: TextStyle(color: Appcolor.textBrownSoft)))
//           : ListView.builder(
//               padding: const EdgeInsets.all(18),
//               itemCount: savedItems.length,
//               itemBuilder: (_, i) {
//                 final item = savedItems[i];
//                 return InkWell(
//                   onTap: () => Navigator.push(context,
//                       MaterialPageRoute(builder: (_) => EducationDetailPage(item: item))),
//                   child: Container(
//                     margin: const EdgeInsets.only(bottom: 12),
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
//                     child: Text(item.title,
//                         style: TextStyle(fontWeight: FontWeight.w600, color: Appcolor.textBrownSoft)),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
