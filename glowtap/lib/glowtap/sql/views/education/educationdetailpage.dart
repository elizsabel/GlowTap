import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/firebase/constant/appcolor.dart';
import 'package:glowtap/glowtap/sql/preference/preference_handler.dart';
import 'package:glowtap/glowtap/sql/views/education/educationdatapage.dart';

class EducationDetailPage extends StatefulWidget {
  final EducationItem item;
  const EducationDetailPage({super.key, required this.item});

  @override
  State<EducationDetailPage> createState() => _EducationDetailPageState();
}

class _EducationDetailPageState extends State<EducationDetailPage> {
  bool isSaved = false;

  @override
  void initState() {
    super.initState();
    checkSaved();
  }

  void checkSaved() async {
    isSaved = await PreferenceHandler.isFavoriteEducation(widget.item.title);
    setState(() {});
  }

  void toggleSave() async {
    await PreferenceHandler.toggleFavoriteEducation(widget.item.title);
    checkSaved();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      appBar: AppBar(
        backgroundColor: Appcolor.button1,
        actions: [
          IconButton(
            icon: Icon(isSaved ? Icons.bookmark : Icons.bookmark_border, color: Colors.white),
            onPressed: toggleSave,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(widget.item.content,
            style: TextStyle(fontSize: 15, color: Appcolor.textBrownSoft, height: 1.5)),
      ),
    );
  }
}
