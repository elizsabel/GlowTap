import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/firebase/constant/appcolor.dart';
import 'package:glowtap/glowtap/sql/views/education/educationdatapage.dart';
import 'package:glowtap/glowtap/sql/views/education/educationdetailpage.dart';
import 'package:glowtap/glowtap/firebase/views/education_fb/favoriteeducationpage.dart';

class EducationPage extends StatefulWidget {
  const EducationPage({super.key});

  @override
  State<EducationPage> createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  String selectedCategory = "Semua";
  String searchQuery = "";

  List<String> categories = [
    "Semua",
    "Basic Skincare",
    "After Treatment",
    "Skin Problems",
    "Lifestyle",
    "Myth vs Fact",
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = educationList.where((e) {
      final matchCategory = selectedCategory == "Semua" || e.category == selectedCategory;
      final matchSearch = e.title.toLowerCase().contains(searchQuery.toLowerCase());
      return matchCategory && matchSearch;
    }).toList();

    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      appBar: AppBar(
        backgroundColor: Appcolor.button1,
        title: const Text("Edukasi & Tips ✨", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FavoriteEducationPage()),
            ),
          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // SEARCH
            TextField(
              onChanged: (v) => setState(() => searchQuery = v),
              decoration: InputDecoration(
                hintText: "Cari tips, contoh: sunscreen...",
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 16),

            // CATEGORY TABS
            SizedBox(
              height: 36,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: categories.map((cat) {
                  final active = selectedCategory == cat;
                  return GestureDetector(
                    onTap: () => setState(() => selectedCategory = cat),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: active ? Appcolor.button1 : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(cat, style: TextStyle(color: active ? Colors.white : Appcolor.textBrownSoft)),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 16),

            // LIST
            Expanded(
              child: ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (_, i) {
                  final item = filtered[i];
                  return InkWell(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => EducationDetailPage(item: item))),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(item.title,
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Appcolor.textBrownSoft)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
