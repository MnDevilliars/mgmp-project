import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../components/my_textfield.dart';
import '../../handler/request_handler.dart';
import '../../util/dropdown.dart';
import '../../model/event_model.dart';
import '../../handler/shared_pref_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../model/artists_model.dart';

class EditEvent extends StatefulWidget {
  final EventModel currentEventData;
  const EditEvent({super.key, required this.currentEventData});

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  RequestHandler requestHandler = RequestHandler();


// textfield variables
  final eventNameController = TextEditingController();
  final locationNameController = TextEditingController();
  final addressController = TextEditingController();
  final dateController = TextEditingController();
  final miscellaneousChargesController = TextEditingController();
  final artistAmountController = TextEditingController();
  final commentController = TextEditingController();

// dropdown variables
  String? selectedArtist;
  String? selectedEventType;
  String? selectedLocation;
  String? selectedDistrict;
  String? selectedTown;
  DateTime? selectedDate;
  int? selectedStatus;
  int? isArtistPaid;
  int? isMiscellaneousPaid;


  // post method jo ID lekar jayega
  String? currentEventID;
  String? selectedArtistID;
  String? selectedEventTypeID;
  String? selectedLocationID;
  String? selectedDistrictID;
  String? selectedTownID;

  List<dynamic> artistTypeList = [];
  List<dynamic> eventTypeList = [];
  List<dynamic> locationNameList = [];
  List<dynamic> stateNameList = ["Meghalaya"];
  List<dynamic> districtNameList = [];
  List<dynamic> townNameList = [];
  List<dynamic> statusList = [
    {'status': 'Pending'},
    {'status': 'Approved'},
    {'status': 'Rejected'},
    {'status': 'Complete'},
  ];
  List<dynamic> isArtistPaidList = [
    {'status': 'Paid', 'code' : 1},
    {'status': 'Not Paid', 'code' : 0},
  ];

  @override
  void initState() {
    super.initState();

    final data = widget.currentEventData;

    // setting displayed value to user
    eventNameController.text = data.eventName;
    locationNameController.text = data.locationName;
    addressController.text = data.address;
    if (data.date != 0) {
      selectedDate = DateTime.fromMicrosecondsSinceEpoch(data.date.toInt());
      dateController.text = DateFormat('dd MMM yyyy').format(selectedDate!);
    }
    miscellaneousChargesController.text = data.otherAmount.toString();
    artistAmountController.text = data.artistAmount.toString();
    commentController.text = data.miscComment;

    selectedEventType = data.eventTypeName;
    selectedArtist = '${data.artistFirstName} ${data.artistMiddleName} ${data.artistLastName}';
    // selectedLocation = data.locationName;
    selectedDistrict = data.district;
    selectedTown = data.town;
    selectedStatus = data.status;


    // setting value to send to server
    currentEventID = data.eventId ?? '';
    selectedArtistID = data.artistId ?? '';
    selectedEventTypeID = data.eventtypeId ?? '';
    selectedLocationID = data.locationId ?? '';
    selectedDistrictID = data.districtId ?? '';
    selectedTownID = data.townId ?? '';

    // fetching dropdown for user to select
    fetchEventList();
    fetchLocationList();
    fetchDistrictList();
    fetchTownList();
    fetchArtistList();
  }

  void _updateEventData() async {
    final data = widget.currentEventData;

    print("************************************************");

    print("Eventname : ${eventNameController.text}");
    print("eventAt : ${convertDateFormat(dateController.text)}");
    print("artistId : $selectedArtistID");
    print("districtId : $selectedDistrictID");
    print("townId : $selectedTownID");
    print("eventtypeId : $selectedEventTypeID");
    print("eventId : $currentEventID");
    print("locationId : $selectedLocationID");
    print("status : $selectedStatus");
    print("locationName : ${locationNameController.text}");
    print("address : ${addressController.text}");
    print("artistFees : ${artistAmountController.text}");
    print("artistIsPayed : $isArtistPaid");
    print("miscellaneous Amount : ${miscellaneousChargesController.text}");
    print("miscellaneousIsPayed : $isMiscellaneousPaid");
    print("comment : ${commentController.text}");

    print("************************************************");


    final eventName = jsonEncode({"eventName":"${eventNameController.text}"});
    final eventAt = jsonEncode({"eventAt":"${convertDateFormat(dateController.text)}"});
    final districtId = jsonEncode({"districtId": selectedDistrictID});
    final townId = jsonEncode({"townId": selectedTownID});
    final eventtypeId = jsonEncode({"eventtypeId": selectedEventTypeID});
    final eventId = jsonEncode({"eventId": data.eventId});
    final locationId = jsonEncode({"locationId": selectedLocationID});
    final status = jsonEncode({"status":selectedStatus});
    final locationDetails = jsonEncode({"locationName":"${locationNameController.text}","address":"${addressController.text}"});
    final method = jsonEncode({"method":1});
    final artistDetail = jsonEncode(
        [
          {
            'artistId' : selectedArtistID,
            'artistFees' : int.parse(artistAmountController.text),
            'artistIsPayed' : isArtistPaid ?? 0,
          }
        ]
    );
    final isVisible = jsonEncode({"isVisible":1});
    final misc_amount = jsonEncode({"misc_amount":int.parse(miscellaneousChargesController.text),"miscIsPayed":isMiscellaneousPaid ?? 0,"comments":""});
    final miscComment = jsonEncode({"miscComment": commentController.text});

    final updatedPayload = [
      artistDetail,
      districtId,
      method,
      status,
      eventtypeId,
      isVisible,
      locationDetails,
      eventAt,
      misc_amount,
      eventName,
      townId,
      eventId,
      miscComment,
      locationId
    ];


    requestHandler.postEventUpdate(updatedPayload);
  }

  String convertDateFormat(String inputDate) {
    DateTime parsedDate = DateFormat("dd MMM yyyy").parse(inputDate);
    String formattedDate = DateFormat("dd-MM-yyyy").format(parsedDate);
    return formattedDate;
  }

  void fetchDistrictList() async {
    final district = await requestHandler.districtInfo();
    setState(() => districtNameList = district ?? []);
  }

  void fetchTownList() async {
    final town = await requestHandler.townInfo('');
    setState(() => townNameList = town ?? []);
  }

  void fetchEventList() async {
    final eventType = await requestHandler.eventsInfo();
    setState(() => eventTypeList = eventType ?? []);
  }

  void fetchArtistList() async {
    final response = await requestHandler.artistsPageData(
      artistStatus: 'NaN',
      artistType: '2',
    );

    if (response != null) {
      List<ArtistModel> artistList = (response as List)
          .map((json) => ArtistModel.fromJson(json))
          .toList();

      artistTypeList.clear();

      for (var artist in artistList) {
        artistTypeList.add({
          'fullName': artist.fullName,
          'id': artist.id,
        });
      }
    } else {
      artistTypeList.clear();
    }
  }

  void fetchLocationList() async {
    final locationName = await requestHandler.locationInfo();
    setState(() => locationNameList = locationName ?? []);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = DateFormat('dd MMM yyyy').format(picked);
      });
    }
  }

  String _getStatusLabel(int? status) {
    switch (status) {
      case 0:
        return 'Pending';
      case 1:
        return 'Approved';
      case 2:
        return 'Rejected';
      case 3:
        return 'Complete';
      default:
        return 'Pending';
    }
  }

  int? _getStatusValue(String statusLabel) {
    switch (statusLabel) {
      case 'Pending':
        return 0;
      case 'Approved':
        return 1;
      case 'Rejected':
        return 2;
      case 'Complete':
        return 3;
      default:
        return 0;
    }
  }

  @override
  void dispose() {
    eventNameController.dispose();
    dateController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Edit Event", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          // Event Name
          Textfield(
            controller: eventNameController,
            hintText: "Event Name",
            obscureText: false,
            prefixIcon: Icons.event,
          ),
          const SizedBox(height: 12),
          // Event List
          Dropdown(
            options: eventTypeList,
            keyInfo: 'eventTypeName',
            label: "Event Type",
            initialValue: selectedEventType,
            onChanged: (value) {
              final selectedEventTypeObj = eventTypeList.firstWhere(
                    (eventType) => eventType['eventTypeName'] == value,
                orElse: () => null,
              );
              if (selectedEventTypeObj != null){
                setState(() {
                  selectedEventType = selectedEventTypeObj['eventTypeName'];
                  selectedEventTypeID = selectedEventTypeObj['_id']['\$oid'];
                });
              }
              print('selected event type id = $selectedEventType : $selectedEventTypeID');
            },
          ),
          const SizedBox(height: 12),
          // Location List
          Dropdown(
            options: locationNameList,
            keyInfo: 'locationName',
            label: "Select Location",
            initialValue: selectedLocation,
            onChanged: (value) {
              final selectedLocationObj = locationNameList.firstWhere(
                    (location) => location['locationName'] == value,
                orElse: () => null,
              );
              if (selectedLocationObj != null){
                setState(() {
                  selectedLocation = selectedLocationObj['locationName'];
                  selectedLocationID = selectedLocationObj['_id']['\$oid'];
                });
              }
              print('selected location id = $selectedLocation : $selectedLocationID');
            },
          ),
          const SizedBox(height: 12),
          // Location Name
          Textfield(
            controller: locationNameController,
            hintText: "Location name",
            obscureText: false,
            prefixIcon: Icons.location_on,
          ),
          const SizedBox(height: 12),
          // District List
          Dropdown(
            options: districtNameList,
            keyInfo: 'districtName',
            label: "District",
            initialValue: selectedDistrict,
            onChanged: (value) {
              final selectedDistrictObj = districtNameList.firstWhere(
                    (district) => district['districtName'] == value,
                orElse: () => null,
              );
              if (selectedDistrictObj != null) {
                setState(() {
                  selectedDistrict = selectedDistrictObj['districtName'];
                  selectedDistrictID = selectedDistrictObj['_id']['\$oid'];
                });
              }
              print('selected district id = $selectedDistrict : $selectedDistrictID');
            },
          ),
          const SizedBox(height: 12),
          // Town List
          Dropdown(
            options: townNameList,
            keyInfo: 'townName',
            label: "Town",
            initialValue: selectedTown,
            onChanged: (value) {
              final selectedTownObj = townNameList.firstWhere(
                    (town) => town['townName'] == value,
                orElse: () => null,
              );
              if (selectedTownObj != null){
                setState(() {
                  selectedTownID = selectedTownObj['townName'];
                  selectedTownID = selectedTownObj['_id']['\$oid'];
                });
              }
              print('selected town id = $selectedTown : $selectedTownID');
            },
          ),
          const SizedBox(height: 12),
          // Address
          Textfield(
            controller: addressController,
            hintText: "Address",
            obscureText: false,
            prefixIcon: Icons.location_on,
          ),
          const SizedBox(height: 12),
          // Date
          GestureDetector(
            onTap: () => _selectDate(context),
            child: AbsorbPointer(
              child: Textfield(
                controller: dateController,
                hintText: "Event Date",
                obscureText: false,
                prefixIcon: Icons.calendar_today,
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Event Status
          Dropdown(
            options: statusList,
            keyInfo: 'status',
            label: "Status",
            initialValue: _getStatusLabel(selectedStatus),
            onChanged: (value) {
              setState(() => selectedStatus = _getStatusValue(value));
              print("yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy $selectedStatus");
            },
          ),
          const SizedBox(height: 12),
          // Artist Name
          Dropdown(
            options: artistTypeList,
            keyInfo: 'fullName',
            label: "Artist Name",
            initialValue: selectedArtist,
            onChanged: (value) {
              final selectedArtistTypeObj = artistTypeList.firstWhere(
                    (eventType) => eventType['fullName'] == value,
                orElse: () => null,
              );
              if (selectedArtistTypeObj != null){
                setState(() {
                  selectedArtist = selectedArtistTypeObj['fullName'];
                  selectedArtistID = selectedArtistTypeObj['id'];
                });
              }
            },
          ),
          const SizedBox(height: 12),
          // Artist Amount
          Textfield(
            controller: artistAmountController,
            hintText: "Artist Amount",
            obscureText: false,
            prefixIcon: Icons.currency_rupee,
          ),
          const SizedBox(height: 12),
          // Artist paid Status
          Dropdown(
            options: isArtistPaidList,
            keyInfo: 'status',
            label: "Artist Paid",
            initialValue: isArtistPaid == null ? 'Paid' : isArtistPaid.toString(),
            onChanged: (value) {
              final selectedArtistPaidObj = isArtistPaidList.firstWhere(
                    (artistPaid) => artistPaid['status'] == value,
                orElse: () => null,
              );
              if (selectedArtistPaidObj != null){
                setState(() {
                  isArtistPaid = selectedArtistPaidObj['code'];
                });
              }
            },
          ),
          const SizedBox(height: 12),
          // Miscellaneous Amount
          Textfield(
            controller: miscellaneousChargesController,
            hintText: "Miscellaneous Amount",
            obscureText: false,
            prefixIcon: Icons.currency_rupee,
          ),
          const SizedBox(height: 12),
          // Miscellaneous paid Status
          Dropdown(
            options: isArtistPaidList,
            keyInfo: 'status',
            label: "Miscellaneous Paid",
            initialValue: isMiscellaneousPaid == null ? 'Not Paid' : isMiscellaneousPaid.toString(),
            onChanged: (value) {
              final selectedMiscellaneousPaidObj = isArtistPaidList.firstWhere(
                    (miscellaneousPaid) => miscellaneousPaid['status'] == value,
                orElse: () => null,
              );
              if (selectedMiscellaneousPaidObj != null){
                setState(() {
                  isMiscellaneousPaid = selectedMiscellaneousPaidObj['code'];
                });
              }
            },
          ),
          const SizedBox(height: 12),
          // Comment
          Textfield(
            controller: commentController,
            hintText: "Comment",
            obscureText: false,
            prefixIcon: Icons.comment,
          ),
          // Submit form
          const SizedBox(height: 20),
          Center(
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: _updateEventData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("UPDATE  EVENT", style: TextStyle(color: Colors.white),),
              ),
            ),
          )
        ],
      ),
    );
  }
}
