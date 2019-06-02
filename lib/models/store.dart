class Store {
  final String county;
  final int licenseNumber;
  final String operationType;
  final String establishmentType;
  final String entityName;
  final String dbaName;
  final int streetNumber;
  final String streetName;
  final String city;
  final String state;
  final int zipCode;
  final int squareFootage;

  Store(
      {this.county,
      this.licenseNumber,
      this.operationType,
      this.establishmentType,
      this.entityName,
      this.dbaName,
      this.streetNumber,
      this.streetName,
      this.city,
      this.state,
      this.zipCode,
      this.squareFootage});

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      county: json['county'],
      licenseNumber: json['license_number'],
      operationType: json['operation_type'],
      establishmentType: json['establishment_type'],
      entityName: json['entity_name'],
      dbaName: json['DBA_name'],
      streetNumber: json['street_number'],
      streetName: json['street_name'],
      city: json['city'],
      state: json['state'],
      zipCode: json['zip_code'],
      squareFootage: json['square_footage'],
    );
  }
}

// "county": "Albany",
// "license_number": 720644,
// "operation_type": "Store",
// "establishment_type": "JAC",
// "entity_name": "SPEEDWAY LLC",
// "DBA_name": "SPEEDWAY #07708",
// "street_number": 601,
// "street_name": "SARATOGA ST",
// "city": "COHOES",
// "state": "NY",
// "zip_code": 12047,
// "square_footage": 2500,
