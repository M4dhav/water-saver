class UserInfo {
  String name;
  String surname;
  String email;
  String contact;
  String country;
  String state;
  String pin;
  String address;
  String dateOfPurchase;

  UserInfo({
    this.name = '',
    this.surname = '',
    this.email = '',
    this.contact = '',
    this.country = '',
    this.state = '',
    this.pin = '',
    this.address = '',
    this.dateOfPurchase = '',
  });

  factory UserInfo.fromFirestore(Map<String, dynamic> data) {
    return UserInfo(
      name: data['name'] ?? '',
      surname: data['surname'] ?? '',
      email: data['email'] ?? '',
      contact: data['contact'] ?? '',
      country: data['country'] ?? '',
      state: data['state'] ?? '',
      pin: data['pin'] ?? '',
      address: data['address'] ?? '',
      dateOfPurchase: data['dateOfPurchase'] ?? 'Not available',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'surname': surname,
      'email': email,
      'contact': contact,
      'country': country,
      'state': state,
      'pin': pin,
      'address': address,
      'dateOfPurchase': dateOfPurchase,
    };
  }

  String getFieldValue(String fieldName) {
    switch (fieldName) {
      case 'Name':
        return name;
      case 'Surname':
        return surname;
      case 'Email':
        return email;
      case 'Contact':
        return contact;
      case 'Country':
        return country;
      case 'State':
        return state;
      case 'Pin':
        return pin;
      case 'Address':
        return address;
      case 'DOP':
        return dateOfPurchase;
      default:
        return '';
    }
  }

  // Set value by field name
  void setFieldValue(String fieldName, String value) {
    switch (fieldName) {
      case 'Name':
        name = value;
        break;
      case 'Surname':
        surname = value;
        break;
      case 'Email':
        email = value;
        break;
      case 'Contact':
        contact = value;
        break;
      case 'Country':
        country = value;
        break;
      case 'State':
        state = value;
        break;
      case 'Pin':
        pin = value;
        break;
      case 'Address':
        address = value;
        break;
    }
  }

  // Get Firestore field name from display name
  String getFirestoreFieldName(String displayName) {
    switch (displayName) {
      case 'Name':
        return 'name';
      case 'Surname':
        return 'surname';
      case 'Email':
        return 'email';
      case 'Contact':
        return 'contact';
      case 'Country':
        return 'country';
      case 'State':
        return 'state';
      case 'Pin':
        return 'pin';
      case 'Address':
        return 'address';
      case 'Date of Purchase':
        return 'dateOfPurchase';
      default:
        return '';
    }
  }

  // Get all editable fields
  static List<String> getEditableFields() {
    return [
      'Name',
      'Surname',
      'Email',
      'Contact',
      'Country',
      'State',
      'Pin',
      'Address',
    ];
  }

  // Check if field is empty
  bool isFieldEmpty(String fieldName) {
    return getFieldValue(fieldName).isEmpty;
  }

  // Copy with new values
  UserInfo copyWith({
    String? name,
    String? surname,
    String? email,
    String? contact,
    String? country,
    String? state,
    String? pin,
    String? address,
    String? dateOfPurchase,
  }) {
    return UserInfo(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      contact: contact ?? this.contact,
      country: country ?? this.country,
      state: state ?? this.state,
      pin: pin ?? this.pin,
      address: address ?? this.address,
      dateOfPurchase: dateOfPurchase ?? this.dateOfPurchase,
    );
  }
}
