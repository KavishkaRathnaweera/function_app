enum LocationConstant {
  CurrentPosition,
  LastReadPosition,
}

enum AddressSelection {
  LocationRadio,
  FromMap,
  FromCurrentLocation,
  Manual,
}

enum PostType {
  NormalPost,
  RegisteredPost,
  Package,
}

enum PostAction {
  Success,
  Fail,
}

enum DatabaseResult {
  Success,
  OnlyDelete,
  OnlyAdded,
  Failed,
  AddressFail,
}
