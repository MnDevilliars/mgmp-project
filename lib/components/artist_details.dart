import 'package:flutter/material.dart';
import '../model/artists_model.dart';
import 'package:go_router/go_router.dart';
import '../util/infoRow.dart';
import '../util/edu_button.dart';
import '../handler/request_handler.dart';
import '../util/delete_confirmation_dialogue.dart';

class ArtistDetailsScreen extends StatelessWidget {
  final ArtistModel artist;
  final RequestHandler requestHandler = RequestHandler();

  ArtistDetailsScreen({super.key, required this.artist});

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
                        "Personal & Professional Details",
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
                              label: "Artist Name",
                              value: "${artist.artistFirstName} ${artist.artistMiddleName} ${artist.artistLastName}",
                              icon: Icons.person,
                            ),
                            InfoRow(
                              label: "About",
                              value: artist.about,
                              icon: Icons.info_outline,
                            ),
                            InfoRow(
                              label: "Contact",
                              value: artist.artistContact.toString(),
                              icon: Icons.phone,
                            ),
                            InfoRow(
                              label: "Email",
                              value: artist.artistEmail,
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
                        value: artist.bankName,
                        icon: Icons.account_balance,
                      ),
                      InfoRow(
                        label: "Account Holder",
                        value: artist.artistAccountHolderName,
                        icon: Icons.account_circle,
                      ),
                      InfoRow(
                        label: "Account Number",
                        value: artist.bankAccountNumber.toString(),
                        icon: Icons.numbers,
                      ),
                      InfoRow(
                        label: "IFSC Number",
                        value: artist.bankIFSC,
                        icon: Icons.code,
                      ),
                      InfoRow(
                        label: "Pan Number",
                        value: artist.panNumber,
                        icon: Icons.article_outlined,
                      ),
                      InfoRow(
                        label: "Status",
                        value: artist.status == 1
                            ? 'Approved'
                            : (artist.status == 2 ? 'Rejected' : 'Pending'),
                        icon: Icons.verified_user,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Card(
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
                          "Description",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          artist.about ?? 'N/A',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ],
                    ),
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
                        onPressed: () {
                          context.push('/edit-event', extra: artist);
                        },
                      ),
                      const SizedBox(width: 15),
                      EduButton(
                        label: "Comment",
                        prefixIcon: Icons.chat_outlined,
                        onPressed: () {},
                      ),
                      const SizedBox(width: 15),
                      EduButton(
                        label: "Delete Artist",
                        prefixIcon: Icons.delete_rounded,
                        onPressed: () {
                          showDeleteConfirmationDialog(
                            context: context,
                            title: "Confirm Deletion",
                            message: "Do you want to delete the Event ?",
                            onConfirm: () {
                              requestHandler.deleteArtist(artist.artistID.toString());
                            },
                          );
                        },
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
