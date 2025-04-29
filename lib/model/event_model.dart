// class EventModel {
//   final String eventName;
//   final int status;
//   final String locationName;
//   final String address;
//   final String district;
//   final String town;
//   final String state;
//   final String eventTypeName;
//   final String artistFirstName;
//   final String artistMiddleName;
//   final String artistLastName;
//   final int artistAmount;
//   final int otherAmount;
//   final double date;
//
//   final String? eventId;
//   final String? locationId;
//   final String? districtId;
//   final String? townId;
//   final String? stateId;
//   final String? eventTypeId;
//   final String? artistId;
//
//   EventModel({
//     required this.eventName,
//     required this.status,
//     required this.locationName,
//     required this.address,
//     required this.district,
//     required this.town,
//     required this.state,
//     required this.eventTypeName,
//     required this.artistFirstName,
//     required this.artistMiddleName,
//     required this.artistLastName,
//     required this.artistAmount,
//     required this.otherAmount,
//     required this.date,
//     this.eventId,
//     this.locationId,
//     this.districtId,
//     this.townId,
//     this.stateId,
//     this.eventTypeId,
//     this.artistId,
//   });
//
//   factory EventModel.fromJson(Map<String, dynamic> json) {
//     return EventModel(
//       eventName: json['eventName'] ?? 'Unknown',
//       status: json['status'] ?? 0,
//       locationName: json['location']?['locationName'] ?? 'Unknown Location',
//       address: json['location']?['address'] ?? 'Unknown Address',
//       district:
//           (json['districtInfo'] != null && json['districtInfo'].isNotEmpty)
//               ? json['districtInfo'][0]['districtName'] ?? 'Unknown District'
//               : 'Unknown District',
//       town:
//           (json['townInfo'] != null && json['townInfo'].isNotEmpty)
//               ? json['townInfo'][0]['townName'] ?? 'Unknown Town'
//               : 'Unknown Town',
//       state:
//           (json['stateInfo'] != null && json['stateInfo'].isNotEmpty)
//               ? json['stateInfo'][0]['name'] ?? 'Unknown State'
//               : 'Unknown State',
//       eventTypeName:
//           (json['eventTypeInfo'] != null && json['eventTypeInfo'].isNotEmpty)
//               ? json['eventTypeInfo'][0]['eventTypeName'] ?? 'Unknown'
//               : 'Unknown',
//       artistFirstName:
//           (json['mergedArtists'] != null && json['mergedArtists'].isNotEmpty)
//               ? json['mergedArtists'][0]['firstName'] ?? '~ Unknown'
//               : '~ Unknown',
//       artistMiddleName:
//           (json['mergedArtists'] != null && json['mergedArtists'].isNotEmpty)
//               ? json['mergedArtists'][0]['middleName'] ?? ''
//               : '',
//       artistLastName:
//           (json['mergedArtists'] != null && json['mergedArtists'].isNotEmpty)
//               ? json['mergedArtists'][0]['lastName'] ?? ''
//               : '',
//       artistAmount:
//           (json['mergedArtists'] != null && json['mergedArtists'].isNotEmpty)
//               ? json['mergedArtists'][0]['artistFees'] ?? 0
//               : 0,
//       otherAmount: json['miscAmount']?['Amount'] ?? 0,
//       date: json['eventAt'] ?? 0,
//
//       eventId: json['_id']?['\$oid']?.toString(),
//       locationId: json['location']?['_id']?['\$oid']?.toString(),
//       districtId: json['location']?['districtId']?['\$oid']?.toString(),
//       townId: json['location']?['townId']?['\$oid']?.toString(),
//       stateId: json['location']?['stateId']?['\$oid']?.toString(),
//       eventTypeId: json['eventTypeId']?['\$oid'].toString(),
//       artistId:
//           (json['mergedArtists'] != null && json['mergedArtists'].isNotEmpty)
//               ? (json['mergedArtists'][0]['_id']?['\$oid'].toString())
//               : '',
//     );
//   }
// }








class EventModel {
  final String eventName;
  final int status;
  final String locationName;
  final String address;
  final String district;
  final String town;
  final String state;
  final String eventTypeName;
  final String artistFirstName;
  final String artistMiddleName;
  final String artistLastName;
  final int artistAmount;
  final int otherAmount;
  final double date;

  final String? eventId;
  final String? locationId;
  final String? districtId;
  final String? townId;
  final String? stateId;
  final String? eventtypeId;
  final String? artistId;

  // New fields
  final int method; // New field
  final int isVisible; // New field
  final int miscIsPayed; // From miscAmount
  final String miscComments; // From miscAmount
  final String miscComment; // From miscComment
  final List<ArtistDetail> artistDetails; // List of artist details

  EventModel({
    required this.eventName,
    required this.status,
    required this.locationName,
    required this.address,
    required this.district,
    required this.town,
    required this.state,
    required this.eventTypeName,
    required this.artistFirstName,
    required this.artistMiddleName,
    required this.artistLastName,
    required this.artistAmount,
    required this.otherAmount,
    required this.date,
    this.eventId,
    this.locationId,
    this.districtId,
    this.townId,
    this.stateId,
    this.eventtypeId,
    this.artistId,
    required this.method, // New field
    required this.isVisible, // New field
    required this.miscIsPayed, // New field
    required this.miscComments, // New field
    required this.miscComment, // New field
    required this.artistDetails, // New field
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      eventName: json['eventName'] ?? 'Unknown',
      status: json['status'] ?? 0,
      locationName: json['location']?['locationName'] ?? 'Unknown Location',
      address: json['location']?['address'] ?? 'Unknown Address',
      district:
      (json['districtInfo'] != null && json['districtInfo'].isNotEmpty)
          ? json['districtInfo'][0]['districtName'] ?? 'Unknown District'
          : 'Unknown District',
      town:
      (json['townInfo'] != null && json['townInfo'].isNotEmpty)
          ? json['townInfo'][0]['townName'] ?? 'Unknown Town'
          : 'Unknown Town',
      state:
      (json['stateInfo'] != null && json['stateInfo'].isNotEmpty)
          ? json['stateInfo'][0]['name'] ?? 'Unknown State'
          : 'Unknown State',
      eventTypeName:
      (json['eventTypeInfo'] != null && json['eventTypeInfo'].isNotEmpty)
          ? json['eventTypeInfo'][0]['eventTypeName'] ?? 'Unknown'
          : 'Unknown',
      artistFirstName:
      (json['mergedArtists'] != null && json['mergedArtists'].isNotEmpty)
          ? json['mergedArtists'][0]['firstName'] ?? '~ Unknown'
          : '~ Unknown',
      artistMiddleName:
      (json['mergedArtists'] != null && json['mergedArtists'].isNotEmpty)
          ? json['mergedArtists'][0]['middleName'] ?? ''
          : '',
      artistLastName:
      (json['mergedArtists'] != null && json['mergedArtists'].isNotEmpty)
          ? json['mergedArtists'][0]['lastName'] ?? ''
          : '',
      artistAmount:
      (json['mergedArtists'] != null && json['mergedArtists'].isNotEmpty)
          ? json['mergedArtists'][0]['artistFees'] ?? 0
          : 0,
      otherAmount: json['miscAmount']?['Amount'] ?? 0,
      date: json['eventAt'] ?? 0,

      eventId: json['_id']?['\$oid']?.toString(),
      locationId: json['location']?['_id']?['\$oid']?.toString(),
      districtId: json['location']?['districtId']?['\$oid']?.toString(),
      townId: json['location']?['townId']?['\$oid']?.toString(),
      stateId: json['location']?['stateId']?['\$oid']?.toString(),
      eventtypeId: json['eventTypeId']?['\$oid'].toString(),
      artistId:
      (json['mergedArtists'] != null && json['mergedArtists'].isNotEmpty)
          ? (json['mergedArtists'][0]['_id']?['\$oid'].toString())
          : '',

      method: json['method'] ?? 1, // Default to 1 if not present
      isVisible: json['isVisible'] ?? 1, // Default to 1 if not present
      miscIsPayed: json['miscAmount']?['miscIsPayed'] ?? 0,
      miscComments: json['miscAmount']?['comments'] ?? "",
      miscComment: json['miscComment'] ?? "",

      artistDetails: (json['mergedArtists'] as List<dynamic>?)
          ?.map((e) => ArtistDetail.fromJson(e))
          .toList() ?? [],
    );
  }
}

class ArtistDetail {
  final String? id;
  final String firstName;
  final String middleName;
  final String lastName;
  final int artistFees;

  ArtistDetail({
    this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.artistFees,
  });

  factory ArtistDetail.fromJson(Map<String, dynamic> json) {
    return ArtistDetail(
      id: json['_id']?['\$oid'],
      firstName: json['firstName'] ?? '',
      middleName: json['middleName'] ?? '',
      lastName: json['lastName'] ?? '',
      artistFees: json['artistFees'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": {"\$oid": id},
      "firstName": firstName,
      "middleName": middleName,
      "lastName": lastName,
      "artistFees": artistFees,
    };
  }
}

