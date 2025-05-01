import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import '../model/event_model.dart';
import '../util/infoRow.dart';
import '../util/edu_button.dart';
import '../handler/request_handler.dart';
import '../util/delete_confirmation_dialogue.dart';

class EventDetailsScreen extends StatelessWidget {
  final EventModel event;
  final RequestHandler requestHandler = RequestHandler();

  EventDetailsScreen({super.key, required this.event});

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
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        event.eventName ?? 'N/A',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _eventBasicInfoCard(context, event),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              _eventDetailsCard(context, event),
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
                        label: "Add",
                        prefixIcon: Icons.add,
                        onPressed: () {},
                      ),
                      const SizedBox(width: 15),
                      EduButton(
                        label: "Edit",
                        prefixIcon: Icons.edit,
                        onPressed: () {
                          context.push('/edit-event', extra: event);
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
                        label: "Delete Event",
                        prefixIcon: Icons.delete_rounded,
                        onPressed: () {
                          showDeleteConfirmationDialog(
                            context: context,
                            title: "Confirm Deletion",
                            message: "Do you want to delete the Event ?",
                            onConfirm: () {
                              requestHandler.deleteEvent(event.eventId.toString());
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

  Widget _eventBasicInfoCard(BuildContext context, EventModel event) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoRow(
              icon: Icons.event,
              label: "Event Type",
              value: event.eventTypeName,
            ),
            const SizedBox(height: 5),
            InfoRow(
              icon: Icons.location_on,
              label: "Location",
              value: event.locationName,
            ),
            const SizedBox(height: 5),
            InfoRow(
              icon: Icons.person,
              label: "Artist Name",
              value:
                  "${event.artistFirstName} ${event.artistMiddleName} ${event.artistLastName}",
            ),
          ],
        ),
      ),
    );
  }

  Widget _eventDetailsCard(BuildContext context, EventModel event) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Address & Location Details",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            InfoRow(icon: Icons.home, label: "Address", value: event.address),
            const SizedBox(height: 5),
            InfoRow(
              icon: Icons.access_time,
              label: "Event Date",
              value: DateFormat('dd MMM yyyy, hh:mm a').format(
                DateTime.fromMicrosecondsSinceEpoch((event.date).toInt()),
              ),
            ),
            const SizedBox(height: 5),
            InfoRow(
              icon: Icons.location_city,
              label: "State",
              value: event.state,
            ),
            const SizedBox(height: 5),
            InfoRow(icon: Icons.location_on, label: "Town", value: event.town),
            const SizedBox(height: 5),
            InfoRow(
              icon: Icons.pin_drop,
              label: "District",
              value: event.district,
            ),
            const SizedBox(height: 5),
            InfoRow(
              icon: Icons.money,
              label: "Artist Amount",
              value: "₹ ${event.artistAmount}",
            ),
            const SizedBox(height: 5),
            InfoRow(
              icon: Icons.money_off,
              label: "Other Amount",
              value: "₹ ${event.otherAmount}",
            ),
            const SizedBox(height: 5),
            InfoRow(
              icon: Icons.verified_user,
              label: "Status",
              value:
                  event.status == 1
                      ? 'Approved'
                      : (event.status == 2 ? 'Rejected' : 'Pending'),
            ),
          ],
        ),
      ),
    );
  }
}
