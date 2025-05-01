import 'package:flutter/material.dart';
import '../../components/event_card.dart';
import '../../appcolors/app_colors.dart';
import '../../handler/request_handler.dart';
import '../../util/dropdown.dart';
import '../../util/refresh_button.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final RequestHandler requestHandler = RequestHandler();
  List<dynamic> eventData = [];
  List<dynamic> districtNames = [];
  List<dynamic> townNames = [];
  String selectedStatus = '0';
  String selectedSearchWith = '';
  bool isLoading = false;

  String getInitials(String searchWith) {
    const districtInitials = {
      'East Khasi Hills': 'EKH',
      'North Garo Hills': 'NGH',
      'West Garo Hills': 'WGH',
      'South Garo Hills': 'SGH',
      'South West Garo Hills': 'SWGH',
      'East Garo Hills': 'EGH',
      'West Khasi Hills': 'WKH',
      'South West Khasi Hills': 'SWKH',
      'Eastern West Khasi Hills': 'EWKH',
      'East Jaintia Hills': 'EJH',
      'West Jaintia Hills': 'WJH',
      'Ribhoi': 'RB',
      'Baghmara': 'BG',
      'Mairang': 'MG',
      'Mawpat': 'MT',
      'Mawlai': 'ML',
      'Nongpoh': 'NH',
      'Shillong': 'SG',
      'Umroi': 'UM',
      'Nongstoin': 'NG',
      'Ampati': 'AT',
      'Rongra': 'RG',
      'Lower Chandmari': 'LC',
    };

    if (searchWith == 'All') return '';
    return districtInitials[searchWith] ?? searchWith;
  }

  void fetchDistrict() async {
    final district = await requestHandler.districtInfo();
    setState(() {
      districtNames = district ?? [];
    });
  }

  void fetchTown(String district) async {
    district = getInitials(district);
    final towns = await requestHandler.townInfo(district ?? '');
    setState(() {
      townNames = towns ?? [];
    });
  }

  void fetchEventData(String status, String searchWith) async {
    setState(() {
      isLoading = true;
      selectedStatus = status;
      selectedSearchWith = searchWith;
    });

    searchWith = getInitials(searchWith);

    final data = await requestHandler.eventPageData(
      eventStatus: status,
      searchWith: searchWith,
    );
    print("event data $data");
    setState(() {
      eventData = data ?? [];
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchDistrict();
    fetchEventData(selectedStatus, selectedSearchWith);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(height: 75,),
                  SizedBox(
                    width: 150,
                    child: Dropdown(
                      options: [
                        {'status': 'All'},
                        {'status': 'Pending'},
                        {'status': 'Approved'},
                        {'status': 'Rejected'},
                        {'status': 'Complete'},
                      ],
                      keyInfo: 'status',
                      label: "Status",
                      onChanged: (value) {
                        setState(() {
                          selectedStatus = value;
                        });
                        fetchEventData(value, selectedSearchWith);
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 150,
                    child: Dropdown(
                      options: districtNames,
                      keyInfo: 'districtName',
                      label: "District",
                      heightFactor: 0.9,
                      onChanged: (value) {
                        setState(() {
                          selectedSearchWith = value;
                        });
                        fetchTown(value);
                        fetchEventData(selectedStatus, value);
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 150,
                    child: Dropdown(
                      options: townNames,
                      keyInfo: 'townName',
                      label: "Town",
                      heightFactor: 0.9,
                      onChanged: (value) {
                        setState(() {
                          selectedSearchWith = value;
                        });
                        fetchEventData(selectedStatus, value);
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  RefreshButton(url: "events", label: "refresh"),
                ],
              ),
            ),
          ),

          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : eventData.isNotEmpty
                ? ListView.builder(
              itemCount: eventData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: EventCard(events: eventData[index]),
                );
              },
            )
                : const Center(
              child: Text(
                "No events available",
                style: TextStyle(
                  color: AppColors.primaryBottomBar,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }
}




// 9609418837
