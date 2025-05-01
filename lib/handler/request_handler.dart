import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'shared_pref_handler.dart';

class RequestHandler {

  final url = 'https://rc-mgmp.themeghalayanage.com';
  final xen_origin = 'gAAAAABj4fitdXGtaMIU4-VcP36xx0ylGf8mrUbBA3IV3-x0dbAbhWRVnqWUVIF62YaMar21HM-uEtg_k0cWZ7lsJ-PCpsZTgZiyevE9v95xtUaBtTPOWbc=';


  Future<dynamic> dashboardPageData() async {
    SharedPrefrenceHandler pref = SharedPrefrenceHandler();
    String sessionToken = await pref.getSessionToken();
    try {
      final response = await http.get(
        Uri.parse('$url/api/resource/adminDashboard'),
        headers: <String, String>{
          'Xen-Origin': xen_origin,
          'XEN-AUTHORIZATION': sessionToken,
        },
      );

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200 && responseData["status"]) {
        return responseData["result"];
      }

    } catch (e, s) {
      debugPrint("$e ,  $s");
      throw Exception('Failed to fetch dashboard data');
    }
  }

  Future<dynamic> eventPageData({String eventStatus = '0', String searchWith = ''}) async {
    SharedPrefrenceHandler pref = SharedPrefrenceHandler();
    String sessionToken = await pref.getSessionToken();
    print("session token $sessionToken");

    if (eventStatus == 'All') eventStatus = '0';
    if (eventStatus == 'Pending') eventStatus = '1';
    if (eventStatus == 'Approved') eventStatus = '2';
    if (eventStatus == 'Rejected') eventStatus = '3';
    if (eventStatus == 'Complete') eventStatus = '4';

    try {
      final response = await http.get(
        Uri.parse('$url/api/component/eEvent/info?eventStatus=$eventStatus&searchWith=$searchWith'),
        headers: <String, String>{
          'Xen-Origin': xen_origin,
          'XEN-AUTHORIZATION': sessionToken,
        },
      );

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200 && responseData["status"]) {
        return responseData["result"];
      } else{
        print("failed to fetch events $responseData");
      }

    } catch (e, s) {
      debugPrint("$e ,  $s");
      throw Exception('Failed to fetch event data');
    }
  }

  Future<dynamic> artistsPageData({String artistStatus = '0', String artistType = '0'}) async {
    SharedPrefrenceHandler pref = SharedPrefrenceHandler();
    String sessionToken = await pref.getSessionToken();

    if (artistStatus == 'All') artistStatus = '0';
    if (artistStatus == 'Pending') artistStatus = '1';
    if (artistStatus == 'Approved') artistStatus = '2';
    if (artistStatus == 'Rejected') artistStatus = '3';

    if (artistType == 'All') artistType = '0';
    if (artistType == 'Individual artist') artistType = '1';
    if (artistType == 'Group artist') artistType = '2';

    try {
      final response = await http.get(
        Uri.parse('$url/api/component/eArtist/info?isIndividual=$artistType&artistStatus=$artistStatus'),
        headers: <String, String>{
          'Xen-Origin': xen_origin,
          'XEN-AUTHORIZATION': sessionToken,
        },
      );

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200 && responseData["status"]) {
        return responseData["result"];
      }

    } catch (e, s) {
      debugPrint("$e ,  $s");
      throw Exception('Failed to fetch artist data');
    }
  }

  Future<dynamic> eventManagerPageData({String managerStatus = '0'}) async {
    SharedPrefrenceHandler pref = SharedPrefrenceHandler();
    String sessionToken = await pref.getSessionToken();

    if (managerStatus == 'All') managerStatus = '3';
    if (managerStatus == 'Pending') managerStatus = '0';
    if (managerStatus == 'Approved') managerStatus = '1';
    if (managerStatus == 'Rejected') managerStatus = '2';


    try {
      final response = await http.get(
        Uri.parse('$url/api/resource/eManager/info?managerStatus=$managerStatus'),
        headers: <String, String>{
          'Xen-Origin': xen_origin,
          'XEN-AUTHORIZATION': sessionToken,
        },
      );

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200 && responseData["status"]) {
        return responseData["result"];
      }

    } catch (e, s) {
      debugPrint("$e ,  $s");
      throw Exception('Failed to fetch event manager data');
    }
  }

  Future<List<dynamic>> districtInfo() async {
    try {
      final response = await http.get(
        Uri.parse('$url/api/component/district/info'),
        headers: <String, String>{
          'Xen-Origin': xen_origin,
        },
      );

      final districtData = jsonDecode(response.body);

      if (response.statusCode == 200 && districtData["status"]) {
         return districtData['result'];
      } else {
        throw Exception('Failed to fetch district info');
      }
    } catch (e, s) {
      debugPrint("Error: $e\nStackTrace: $s");
      throw Exception('Failed to fetch district info');
    }
  }

  Future<dynamic> townInfo(String district) async {
    try {
      final response = await http.get(
        Uri.parse('$url/api/component/town/info?districtCode=$district'),
        headers: <String, String>{
          'Xen-Origin': xen_origin,
        },
      );

      final townData = jsonDecode(response.body);
      if (response.statusCode == 200 && townData["status"]) {
        return townData['result'];
      } else {
        throw Exception('Failed to fetch town info');
      }

    } catch (e, s) {
      debugPrint("$e ,  $s");
      throw Exception('Failed to fetch town names');
    }
  }

  Future<dynamic> locationInfo() async {
    try {
      final response = await http.get(
        Uri.parse('$url/api/component/location/info'),
        headers: <String, String>{
          'Xen-Origin': xen_origin,
        },
      );

      final locationData = jsonDecode(response.body);
      if (response.statusCode == 200 && locationData["status"]) {
        return locationData['result'];
      } else {
        throw Exception('Failed to fetch location info');
      }

    } catch (e, s) {
      debugPrint("$e ,  $s");
      throw Exception('Failed to fetch location names');
    }
  }

  Future<dynamic> eventsInfo() async {
    try {
      final response = await http.get(
        Uri.parse('$url/api/component/eventtype/info'),
        headers: <String, String>{
          'Xen-Origin': xen_origin,
        },
      );

      final eventsData = jsonDecode(response.body);
      if (response.statusCode == 200 && eventsData["status"]) {
        return eventsData['result'];
      } else {
        throw Exception('Failed to fetch events info');
      }

    } catch (e, s) {
      debugPrint("$e ,  $s");
      throw Exception('Failed to fetch events names');
    }
  }

  Future<bool> postEventUpdate(List eventData) async {
    SharedPrefrenceHandler pref = SharedPrefrenceHandler();
    String sessionToken = await pref.getSessionToken();

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$url/api/component/addevent'),
      );

      request.headers.addAll({
        'Xen-Origin': xen_origin,
        'XEN-AUTHORIZATION': sessionToken,
      });

      final fieldNames = [
        'artistDetails',
        'districtId',
        'method',
        'status',
        'eventtypeId',
        'isVisible',
        'locationDetails',
        'eventAt',
        'misc_amount',
        'eventName',
        'townId',
        'eventId',
        'miscComment',
        'locationId'
      ];

      for (int i = 0; i < eventData.length; i++) {
        request.fields[fieldNames[i]] = eventData[i];
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      final responseData = jsonDecode(response.body);
      print("#################################### $responseData");

      if (response.statusCode == 200 && responseData['status']) {
        return true;
      } else {
        debugPrint("Failed: ${response.body}");
        return false;
      }
    } catch (e, s) {
      debugPrint("Exception: $e\nStackTrace: $s");
      return false;
    }
  }

  void deleteManager(String managerID) async {
    SharedPrefrenceHandler pref = SharedPrefrenceHandler();
    String sessionToken = await pref.getSessionToken();
    try {
      final response = await http.delete(
          Uri.parse('$url/api/component/updateManager'),
          headers: <String, String>{
            'Xen-Origin': xen_origin,
            'XEN-AUTHORIZATION': sessionToken,
          },
          body: jsonEncode({
            "id": managerID,
            "method": 2,
          })
      );
      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200 && responseData["status"]) {
        return responseData["message"];
      }
    } catch (e, s) {
      debugPrint("$e ,  $s");
      debugPrint('Failed to delete manager with managerID: $managerID');
    }
  }

  void deleteArtist(String artistID) async {
    SharedPrefrenceHandler pref = SharedPrefrenceHandler();
    String sessionToken = await pref.getSessionToken();
    try {
      final response = await http.delete(
          Uri.parse('$url/api/component/addartist'),
          headers: <String, String>{
            'Xen-Origin': xen_origin,
            'XEN-AUTHORIZATION': sessionToken,
          },
          body: jsonEncode({
            "id": artistID,
            "method": 2,
          })
      );
      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200 && responseData["status"]) {
        return responseData["message"];
      }
    } catch (e, s) {
      debugPrint("$e ,  $s");
      print('Failed to delete artist with artistID: $artistID');
    }
  }

  void deleteEvent(String eventID) async {
    SharedPrefrenceHandler pref = SharedPrefrenceHandler();
    String sessionToken = await pref.getSessionToken();
    try {
      final response = await http.delete(
          Uri.parse('$url/api/component/addevent'),
          headers: <String, String>{
            'Xen-Origin': xen_origin,
            'XEN-AUTHORIZATION': sessionToken,
          },
          body: jsonEncode({
            "id": eventID,
            "method": 2,
          })
      );

      final responseData = jsonDecode(response.body);
      print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ $responseData");
      if (response.statusCode == 200 && responseData["status"]) {
        return responseData["message"];
      }
    } catch (e, s) {
      debugPrint("$e ,  $s");
      print('Failed to delete event with eventID: $eventID');
    }
  }

}

