// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:math';

import 'package:riverpod/riverpod.dart';

class DataRiverpod extends Notifier<List<Data>> {
  @override
  List<Data> build() {
    return [
      Data(name: "John", value: 42),
      Data(name: "Alice", value: 19),
      Data(name: "Bob", value: 35),
      Data(name: "Eva", value: 28),
      Data(name: "Daniel", value: 53),
      Data(name: "Olivia", value: 24),
      Data(name: "Sophia", value: 31),
      Data(name: "Liam", value: 47),
      Data(name: "Ava", value: 22),
      Data(name: "Mason", value: 39),
    ];
  }

  updateRandom() {
    final val = Random().nextInt(120);

    final random = val % 10;

    final data = [...state];
    data[random] = Data(name: data[random].name, value: val);
    state = data;
  }
}

final dataProvider =
    NotifierProvider<DataRiverpod, List<Data>>(DataRiverpod.new);

class Data {
  final String name;
  final int value;
  Data({
    required this.name,
    required this.value,
  });

  Data copyWith({
    String? name,
    int? value,
  }) {
    return Data(
      name: name ?? this.name,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'value': value,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      name: map['name'] as String,
      value: map['value'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) =>
      Data.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Data(name: $name, value: $value)';

  @override
  bool operator ==(covariant Data other) {
    if (identical(this, other)) return true;

    return other.name == name && other.value == value;
  }

  @override
  int get hashCode => name.hashCode ^ value.hashCode;
}
