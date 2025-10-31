import 'package:flutter/material.dart';

class TreatmentCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String price;
  final VoidCallback onBooking;

  const TreatmentCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    required this.onBooking,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xFFF4C9D0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.network(
              imageUrl,
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5A4A48),
                  ),
                ),
                SizedBox(height: 4),

                Text(
                  description,
                  style: TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 13,
                    color: Color(0xFF5A4A48).withOpacity(0.7),
                  ),
                ),

                SizedBox(height: 8),
                Text(
                  price,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5A4A48),
                  ),
                ),
                SizedBox(height: 12),

                ElevatedButton(
                  onPressed: onBooking,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF4C9D0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: Size(double.infinity, 38),
                  ),
                  child: Text(
                    "Booking",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
