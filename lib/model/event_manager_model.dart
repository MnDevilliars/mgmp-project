class ManagerModel {
  final String managerID;
  final String managerFirstName;
  final String managerMiddleName;
  final String managerLastName;
  final String managerContact;
  final String managerEmail;
  final String bankName;
  final String bankAccountNumber;
  final String bankIFSC;
  final String status;

  ManagerModel({
    required this.managerID,
    required this.managerFirstName,
    required this.managerMiddleName,
    required this.managerLastName,
    required this.managerContact,
    required this.managerEmail,
    required this.bankName,
    required this.bankAccountNumber,
    required this.bankIFSC,
    required this.status,
  });

  factory ManagerModel.fromJson(Map<String, dynamic> json) {
    return ManagerModel(
      managerID: (json['accountInfo'] != null && json['accountInfo'].isNotEmpty)
          ? (json['accountInfo'][0]['_id']?['\$oid']) : '~ Unknown',
      managerFirstName:
          (json['accountInfo'] != null && json['accountInfo'].isNotEmpty)
              ? json['accountInfo'][0]['firstName'] ?? '~Unknown'
              : '~ Unknown',
      managerMiddleName:
          (json['accountInfo'] != null && json['accountInfo'].isNotEmpty)
              ? json['accountInfo'][0]['middleName'] ?? ''
              : '',
      managerLastName:
          (json['accountInfo'] != null && json['accountInfo'].isNotEmpty)
              ? json['accountInfo'][0]['lastName'] ?? ''
              : '',
      managerContact:
      (json['accountInfo'] != null &&
          json['accountInfo'] is List &&
          json['accountInfo'].isNotEmpty &&
          json['accountInfo'][0] is Map &&
          json['accountInfo'][0]['contact'] != null &&
          json['accountInfo'][0]['contact'] is List &&
          json['accountInfo'][0]['contact'].isNotEmpty &&
          json['accountInfo'][0]['contact'][0]['value'] != null)
          ? json['accountInfo'][0]['contact'][0]['value'].toString()
          : 'No Contact',

      managerEmail:
          (json['accountInfo'] != null && json['accountInfo'].isNotEmpty)
              ? ((json['accountInfo'][0]['contact'] != null &&
                      json['accountInfo'][0]['contact'].isNotEmpty)
                  ? json['accountInfo'][0]['contact'][2]['value1'] ??
                      'Email not found'
                  : 'Email not found')
              : 'Email not found',
      bankName:
          (json['accountInfo'] != null && json['accountInfo'].isNotEmpty)
              ? ((json['accountInfo'][0]['bankdetails'] != null &&
                      json['accountInfo'][0]['bankdetails'].isNotEmpty)
                  ? json['accountInfo'][0]['bankdetails'][0]['bankName'] ??
                      'No Bank Details'
                  : 'No Bank Details')
              : 'No Bank Details',
      bankAccountNumber:
          (json['bankDetails'] != null &&
                  json['bankDetails'] is List &&
                  json['bankDetails'].isNotEmpty &&
                  json['bankDetails'][0] is Map &&
                  json['bankDetails'][0]['accountNumber'] != null)
              ? json['bankDetails'][0]['accountNumber'].toString()
              : 'No Account Detail',
      bankIFSC:
          (json['accountInfo'] != null && json['accountInfo'].isNotEmpty)
              ? ((json['accountInfo'][0]['bankdetails'] != null &&
                      json['accountInfo'][0]['bankdetails'].isNotEmpty)
                  ? json['accountInfo'][0]['bankdetails'][0]['ifscCode'] ??
                      'No IFSC Code'
                  : 'No IFSC Code')
              : 'No IFSC Code',
      status:
          (json['accountInfo'] != null && json['accountInfo'].isNotEmpty)
              ? json['accountInfo'][0]['firstName'] ?? 0
              : 0,
    );
  }
}
