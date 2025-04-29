import 'package:flutter/material.dart';
import '../appcolors/app_colors.dart';
import '../model/event_manager_model.dart';
import 'event_manager_details.dart';

class EventManagerCard extends StatelessWidget {
  final Map<String, dynamic> eventManagers;

  const EventManagerCard({super.key, required this.eventManagers});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                EventManagerDetailsScreen(eventManager: ManagerModel.fromJson(eventManagers)),
          ),
        );
      },
      child: _buildFrontCard(ManagerModel.fromJson(eventManagers)),
    );
  }

  Widget _buildFrontCard(ManagerModel eventManager) {
    return Card(
      color: Colors.white, // Card background color
      shadowColor: Colors.black54, // Shadow color for the card
      elevation: 8,
      margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event manager name with gradient background
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
                "${eventManager.managerFirstName} ${eventManager.managerMiddleName} ${eventManager.managerLastName}",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Title text color
                ),
              ),
            ),
            const Divider(color: Color(0xFF444444)), // Divider color
            const SizedBox(height: 12),
            // Info boxes for contact and email inside a Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: _infoBox(Icons.phone, "Contact", eventManager.managerContact)),
                Flexible(child: _infoBox(Icons.email_outlined, "Email", eventManager.managerEmail)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoBox(IconData icon, String label, String value) {
    return Container(
      width: 170,
      height: 85,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F4), // Light grey background for info boxes
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: const Color(0xFF7B61FF)), // Purple icon color
              const SizedBox(width: 10),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54, // Label text color
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.black54, // Value text color
            ),
          ),
        ],
      ),
    );
  }
}
