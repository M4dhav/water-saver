import 'dart:ffi';

class Users {
  final String addOn;
  final String address;
  final Int cable;
  final String city;
  final Int contact;
  final String country;
  final DateTime dop;
  final String name;
  final Int pin;
  final String prodCat;
  final String socket;
  final String state;
  final String surname;
  final Int reservoir;
  final Int tank;

  Users({
    required this.addOn,
    required this.address,
    required this.cable,
    required this.city,
    required this.contact,
    required this.country,
    required this.dop,
    required this.name,
    required this.pin,
    required this.prodCat,
    required this.socket,
    required this.state,
    required this.surname,
    required this.reservoir,
    required this.tank,
  });

  Users.fromMap(Map<String, dynamic> map)
      : addOn = map['addOn'],
        address = map['address'],
        cable = map['cable'],
        city = map['city'],
        contact = map['contact'],
        country = map['country'],
        dop = DateTime.parse(map['dop']),
        name = map['name'],
        pin = map['pin'],
        prodCat = map['prodCat'],
        socket = map['socket'],
        state = map['state'],
        surname = map['surname'],
        reservoir = map['reservoir'],
        tank = map['tank'];

  Map<String, dynamic> toMap() {
    return {
      'addOn': addOn,
      'address': address,
      'cable': cable,
      'city': city,
      'contact': contact,
      'country': country,
      'dop': dop,
      'name': name,
      'pin': pin,
      'prodCat': prodCat,
      'socket': socket,
      'state': state,
      'surname': surname,
      'reservoir': reservoir,
      'tank': tank,
    };
  }
}
