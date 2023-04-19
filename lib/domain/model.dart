class Customer {
  String id;
  String name;
  int numOfNotifications;

  Customer(
      {required this.id, required this.name, required this.numOfNotifications});
}

class Contacts {
  String phone;
  String email;
  String link;

  Contacts({required this.phone, required this.email, required this.link});
}

class Authentication {
  Customer? customer;
  Contacts? contacts;

  Authentication({required this.contacts, required this.customer});
}
