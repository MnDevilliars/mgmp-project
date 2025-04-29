class ArtistModel {
  final String id;
  final String artistFirstName;
  final String artistMiddleName;
  final String artistLastName;
  final String artistAccountHolderName;
  final String panNumber;
  final String about;
  final String artistContact;
  final String artistEmail;
  final String bankName;
  final String bankAccountNumber;
  final String bankIFSC;
  final int status;

  ArtistModel({
    required this.id,
    required this.artistFirstName,
    required this.artistMiddleName,
    required this.artistLastName,
    required this.artistAccountHolderName,
    required this.panNumber,
    required this.about,
    required this.artistContact,
    required this.artistEmail,
    required this.bankName,
    required this.bankAccountNumber,
    required this.bankIFSC,
    required this.status,
  });

  factory ArtistModel.fromJson(Map<String, dynamic> json) {
    return ArtistModel(
      id: json['id'] ?? '',
      artistFirstName: json['firstName']?.toString() ?? '~ Unknown',
      artistMiddleName: json['middleName']?.toString() ?? '~ Unknown',
      artistLastName: json['lastName']?.toString() ?? '~ Unknown',
      artistAccountHolderName: json['accountHolderName'] ?? '~ Unknown',
      panNumber: json['panNumber'] ?? "please update PAN Number",
      about: json['description'] ?? "please add description",
      artistContact: (json['contact'] != null &&
          json['contact'] is List &&
          json['contact'].isNotEmpty &&
          json['contact'][0] is Map &&
          json['contact'][0]['value'] != null)
          ? json['contact'][0]['value'].toString()
          : 'No Contact',
      artistEmail: (json['contact'] != null && json['contact'].isNotEmpty)
          ? json['contact'][2]['value1'] ?? 'No Email'
          : 'No Email',
      bankName: (json['bankDetails'] != null && json['bankDetails'].isNotEmpty)
          ? json['bankDetails'][0]['bankName'] ?? 'No Bank Detail'
          : 'No Bank Detail',
      bankAccountNumber: (json['bankDetails'] != null &&
          json['bankDetails'] is List &&
          json['bankDetails'].isNotEmpty &&
          json['bankDetails'][0] is Map &&
          json['bankDetails'][0]['accountNumber'] != null)
          ? json['bankDetails'][0]['accountNumber'].toString()
          : 'No Account Detail',
      bankIFSC: (json['bankDetails'] != null && json['bankDetails'].isNotEmpty)
          ? json['bankDetails'][0]['ifscCode'] ?? 'No IFSC code'
          : 'No IFSC code',
      status: json['status'] ?? 0,
    );
  }

  String get fullName {
    if (artistMiddleName.isNotEmpty && artistMiddleName != '~ Unknown') {
      return '$artistFirstName $artistMiddleName $artistLastName';
    } else {
      return '$artistFirstName $artistLastName';
    }
  }
}
