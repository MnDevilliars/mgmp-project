import 'package:flutter/material.dart';
import '../../appcolors/app_colors.dart';
import '../../components/event_manager_card.dart';
import '../../handler/request_handler.dart';
import '../../util/dropdown.dart';

class EventManagersPage extends StatefulWidget {
  const EventManagersPage({Key? key}) : super(key: key);

  @override
  State<EventManagersPage> createState() => _EventManagersPageState();
}

class _EventManagersPageState extends State<EventManagersPage> {
  final RequestHandler requestHandler = RequestHandler();
  List<dynamic> eventManagerData = [];
  String selectedStatus = 'All';
  bool isLoading = false;

  void fetchEventManagerData(String status) async {
    setState(() {
      isLoading = true;
      selectedStatus = status;
    });

    final data = await requestHandler.eventManagerPageData(managerStatus: status);

    setState(() {
      eventManagerData = data ?? [];
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchEventManagerData(selectedStatus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Dropdown(
              options: [
                {'status': 'All'},
                {'status': 'Pending'},
                {'status': 'Approved'},
                {'status': 'Rejected'},
              ],
              keyInfo: 'status',
              label: "Select Status",
              onChanged: fetchEventManagerData,
              width: double.infinity,
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : eventManagerData.isNotEmpty
                ? ListView.builder(
              itemCount: eventManagerData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: EventManagerCard(eventManagers: eventManagerData[index]),
                );
              },
            )
                : const Center(child: Text("No Event Manager available")),
          ),
        ],
      ),
    );
  }
}
