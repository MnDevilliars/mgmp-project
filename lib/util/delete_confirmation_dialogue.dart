import 'package:flutter/material.dart';

Future<void> showDeleteConfirmationDialog({
  required BuildContext context,
  required String title,
  required String message,
  required VoidCallback onConfirm,
}) async {
  return showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(26, 12, 25, 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 35),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.red,
              ),
            ),
          ],
        ),
        content: Text(
          message,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text(
              "No",
              style: TextStyle(color: Colors.green, fontSize: 20),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(dialogContext).pop(); // Close the dialog
              onConfirm(); // Perform delete action

              // Show success card overlay
              final overlay = Overlay.of(context);
              final overlayEntry = OverlayEntry(
                builder: (context) => Positioned(
                  top: MediaQuery.of(context).size.height * 0.4,
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                  child: Material(
                    color: Colors.transparent,
                    child: Card(
                      color: Colors.green.shade600,
                      elevation: 8,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            "Deleted successfully!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );

              overlay.insert(overlayEntry);

              await Future.delayed(const Duration(seconds: 1));
              overlayEntry.remove();
              Navigator.of(context).pushNamed('/events');
            },
            child: const Text(
              "Yes",
              style: TextStyle(color: Colors.red, fontSize: 20),
            ),
          ),
        ],
      );
    },
  );
}
