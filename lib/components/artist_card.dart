import 'package:flutter/material.dart';
import '../model/artists_model.dart';
import 'artist_details.dart';

class ArtistCard extends StatelessWidget {
  final Map<String, dynamic> artists;

  const ArtistCard({super.key, required this.artists});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ArtistDetailsScreen(artist: ArtistModel.fromJson(artists)),
          ),
        );
      },
      child: _buildFrontCard(ArtistModel.fromJson(artists)),
    );
  }

  Widget _buildFrontCard(ArtistModel artist) {
    return Card(
      color: Colors.white, // Card background color
      shadowColor: Colors.black54, // Shadow color for the card
      elevation: 8,
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Artist Name with gradient background
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF7B61FF), Color(0xFF927EFF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "${artist.artistFirstName} ${artist.artistMiddleName} ${artist.artistLastName}",
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Title text color
                ),
              ),
            ),
            const Divider(color: Color(0xFF444444)), // Divider color
            const SizedBox(height: 5),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 15,
              runSpacing: 15,
              children: [
                _infoBox(Icons.phone, "Contact", artist.artistContact.toString()),
                _infoBox(Icons.email_outlined, "Email", artist.artistEmail.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoBox(IconData icon, String label, String value) {
    return Container(
      width: 172,
      height: 70,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F4), // Light grey background for info boxes
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: const Color(0xFF7B61FF)), // Purple icon color
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54, // Description text color
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54, // Description text color
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
