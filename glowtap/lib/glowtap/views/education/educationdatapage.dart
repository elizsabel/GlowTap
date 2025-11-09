class EducationItem {
  final String title;
  final String category;
  final String content;

  EducationItem({
    required this.title,
    required this.category,
    required this.content,
  });
}

List<EducationItem> educationList = [
  EducationItem(
    title: "Kenapa Harus Pakai Sunscreen?",
    category: "Basic Skincare",
    content: """
Sunscreen bukan hanya untuk menghindari kulit gosong, tapi untuk:

• Menahan penuaan dini ✨
• Menjaga kulit tetap cerah merata
• Melindungi kolagen agar kulit tetap kencang
• Mencegah flek hitam

Gunakan setiap hari, meskipun di dalam ruangan 💗
Ulangi setiap 4 jam ya!
""",
  ),
  EducationItem(
    title: "Aftercare DNA Salmon",
    category: "After Treatment",
    content: """
Untuk hasil glowing maksimal:

Hindari:
• Sauna & panas berlebih 48 jam
• Makeup tebal 24 jam pertama
• Olahraga berat (panas & keringat)

Yang dianjurkan:
• Kompres dingin lembut
• Fokus hidrasi (moisturizer calming)
• Minum air putih cukup ✨
""",
  ),
  
  // Kamu bisa lanjut tambah di sini 💗
];
