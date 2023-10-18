class User {
  int? id;
  String? name;
  String? contact;
  String? description;

  userMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null; //! We are not passing ID.
    mapping['name'] = name!;
    mapping['contact'] = contact!;
    mapping['description'] = description!; //! Also use like description!
    return mapping;
  }
}
