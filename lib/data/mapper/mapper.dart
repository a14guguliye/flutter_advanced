import 'package:complete_advanced_flutter/app/extensions.dart';
import 'package:complete_advanced_flutter/data/responses/responses.dart';

import '../../domain/model.dart';

const EMPTY = "";

const ZERO = 0;

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
        id: this?.id?.orEmpty() ?? EMPTY,
        name: this?.name.orEmpty() ?? EMPTY,
        numOfNotifications: this?.numberOfNotifications?.orZero() ?? ZERO);
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
        phone: this?.phone?.orEmpty() ?? EMPTY,
        email: this?.email?.orEmpty() ?? EMPTY,
        link: this?.link?.orEmpty() ?? EMPTY);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
        contacts: this?.phone?.toDomain(),
        customer: this?.customer?.toDomain());
  }
}
