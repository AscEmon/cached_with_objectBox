import 'package:objectbox/objectbox.dart';

class Person {
  Person({
    this.statusCode,
    this.person,
  });

  int? statusCode;
  List<PersonElement>? person;

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        statusCode: json["status_code"] == null ? null : json["status_code"],
        person: json["person"] == null
            ? null
            : List<PersonElement>.from(
                json["person"].map((x) => PersonElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode == null ? null : statusCode,
        "person": person == null
            ? null
            : List<dynamic>.from(person!.map((x) => x.toJson())),
      };
}

/**
 * Entity and Sync is required for create for the cached reference.
 * Please also ensure the id
 */
@Entity()
@Sync()
class PersonElement {
  PersonElement({
    this.id = 0,
    this.name,
    this.age,
  });
  int id;
  String? name;
  int? age;

  factory PersonElement.fromJson(Map<String, dynamic> json) => PersonElement(
        name: json["name"] == null ? null : json["name"],
        age: json["age"] == null ? null : json["age"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "age": age == null ? null : age,
      };
}
