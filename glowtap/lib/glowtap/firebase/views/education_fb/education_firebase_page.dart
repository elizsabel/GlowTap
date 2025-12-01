import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/firebase/constant/appcolor.dart';
import 'package:glowtap/glowtap/firebase/models_firebase/educationmodel.dart';
import 'package:glowtap/glowtap/firebase/service/education_service.dart';
import 'package:glowtap/glowtap/firebase/views/education_fb/education_detailfirebase_page.dart';

class EducationFirebasePage extends StatefulWidget {
  const EducationFirebasePage({super.key});

  @override
  State<EducationFirebasePage> createState() => _EducationFirebasePageState();
}

class _EducationFirebasePageState extends State<EducationFirebasePage> {
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

  List<EducationModel> allItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  
  // LOAD DATA DARI FIREBASE
 
  Future<void> loadData() async {
    setState(() => isLoading = true);

    final data = await EducationService.getAllEducation();

    setState(() {
      allItems = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // FILTER LOCAL SETELAH FETCH
    final filtered = allItems.where((e) {
      final matchCategory =
          selectedCategory == "Semua" || e.category == selectedCategory;
      final matchSearch = e.title.toLowerCase().contains(
        searchQuery.toLowerCase(),
      );
      return matchCategory && matchSearch;
    }).toList();

    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      appBar: AppBar(
        backgroundColor: Appcolor.button1,
        title: const Text(
          "Edukasi & Tips ✨",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.bookmark, color: Colors.white),
          //   onPressed: () {
          //     // Navigator.push(
          //     //   context,
          //     //   MaterialPageRoute(
          //     //     builder: (_) => const FavoriteEducationPage(),
          //     //   ),
          //     // );
          //   },
          // ),
        ],
      ),

      
      // BODY
 
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.pink))
          : Padding(
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // CATEGORY
                  SizedBox(
                    height: 36,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: categories.map((cat) {
                        final active = selectedCategory == cat;
                        return GestureDetector(
                          onTap: () => setState(() {
                            selectedCategory = cat;
                          }),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: active ? Appcolor.button1 : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              cat,
                              style: TextStyle(
                                color: active
                                    ? Colors.white
                                    : Appcolor.textBrownSoft,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // LIST FIREBASE
                  Expanded(
                    child: filtered.isEmpty
                        ? const Center(
                            child: Text(
                              "Tidak ada data ditemukan 💗",
                              style: TextStyle(color: Colors.black54),
                            ),
                          )
                        : ListView.builder(
                            itemCount: filtered.length,
                            itemBuilder: (_, i) {
                              final item = filtered[i];
                              return InkWell(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        EducationDetailFirebasePage(item: item),
                                  ),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  margin: const EdgeInsets.only(bottom: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Text(
                                    item.title,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Appcolor.textBrownSoft,
                                    ),
                                  ),
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
