import 'package:flutter/material.dart';
import 'package:glowtap/glowtap/constant/appcolor.dart';
import 'package:glowtap/glowtap/database/db_helper.dart';
import 'package:glowtap/glowtap/dokter/doctormodelpage.dart';
import 'package:glowtap/glowtap/views/doctorupsetpage.dart';
import 'package:glowtap/glowtap/views/doctorviewpage.dart';


class DoctorListPage extends StatefulWidget {
  const DoctorListPage({super.key});

  @override
  State<DoctorListPage> createState() => _DoctorListPageState();
}

class _DoctorListPageState extends State<DoctorListPage> {
  List<DoctorModel> items = [];
  final searchC = TextEditingController();

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    items = await DbHelper.getDoctors(query: searchC.text);
    setState(() {});
  }

  Future<void> remove(int id) async {
    await DbHelper.deleteDoctor(id);
    await load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.softPinkPastel,
      appBar: AppBar(
        backgroundColor: Appcolor.button1,
        title: const Text("Dokter GlowTap", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Appcolor.button1,
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (_) => const DoctorUpsertPage()));
          load();
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: searchC,
              decoration: InputDecoration(
                hintText: "Cari nama/spesialis/area…",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
              onChanged: (_) => load(),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: items.isEmpty
                ? const Center(child: Text("Belum ada dokter"))
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (_, i) {
                      final d = items[i];
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Appcolor.textBrownLight.withOpacity(.2)),
                        ),
                        child: ListTile(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DoctorViewPage(data: d))),
                          leading: CircleAvatar(
                            backgroundColor: Appcolor.button1.withOpacity(.15),
                            child: Text(d.name.isNotEmpty ? d.name[0] : '?'),
                          ),
                          title: Text(d.name, style: TextStyle(color: Appcolor.textBrownSoft, fontWeight: FontWeight.w600)),
                          subtitle: Text("${d.specialty} • ${d.area}\n⭐ ${d.rating.toStringAsFixed(1)} • ${d.price}",
                              maxLines: 2, overflow: TextOverflow.ellipsis),
                          isThreeLine: true,
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () async {
                                  await Navigator.push(context, MaterialPageRoute(builder: (_) => DoctorUpsertPage(data: d)));
                                  load();
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => remove(d.id!),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
