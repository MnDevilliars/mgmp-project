import 'package:flutter/material.dart';
import '../model/event_manager_model.dart';
import '../util/infoRow.dart';
import '../util/edu_button.dart';

class EventManagerDetailsScreen extends StatelessWidget {
  final ManagerModel eventManager;

  const EventManagerDetailsScreen({super.key, required this.eventManager});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF7B61FF), Color(0xFF927EFF)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Personal Details",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InfoRow(
                              label: "Manager Name",
                              value:
                              "${eventManager.managerFirstName} ${eventManager.managerMiddleName} ${eventManager.managerLastName}",
                              icon: Icons.person,
                            ),
                            InfoRow(
                              label: "Contact",
                              value: eventManager.managerContact.toString(),
                              icon: Icons.phone,
                            ),
                            InfoRow(
                              label: "Email",
                              value: eventManager.managerEmail,
                              icon: Icons.email,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Bank & Status Details",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      InfoRow(
                        label: "Bank Name",
                        value: eventManager.bankName,
                        icon: Icons.account_balance,
                      ),
                      InfoRow(
                        label: "Account Number",
                        value: eventManager.bankAccountNumber.toString(),
                        icon: Icons.numbers,
                      ),
                      InfoRow(
                        label: "IFSC Number",
                        value: eventManager.bankIFSC,
                        icon: Icons.code,
                      ),
                      InfoRow(
                        label: "Status",
                        value: eventManager.status == 1
                            ? 'Approved'
                            : (eventManager.status == 2 ? 'Rejected' : 'Pending'),
                        icon: Icons.verified_user,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      EduButton(
                        label: "Edit",
                        prefixIcon: Icons.edit,
                        onPressed: () {},
                      ),
                      const SizedBox(width: 15),
                      EduButton(
                        label: "Comment",
                        prefixIcon: Icons.chat_outlined,
                        onPressed: () {},
                      ),
                      const SizedBox(width: 15),
                      EduButton(
                        label: "Delete Event",
                        prefixIcon: Icons.delete_rounded,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
