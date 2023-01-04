import 'dart:convert';

class Station {
  final int? id;
  final String station;
  final String code;
  final String imageURL;

  Station({
    this.id,
    required this.station,
    required this.code,
    required this.imageURL,
  });

  Station copyWith({
    int? id,
    String? station,
    String? code,
    String? imageURL,
  }) {
    return Station(
      id: id ?? this.id,
      station: station ?? this.station,
      code: code ?? this.code,
      imageURL: imageURL ?? this.imageURL,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'station': station});
    result.addAll({'code': code});
    result.addAll({'imageURL': imageURL});

    return result;
  }

  factory Station.fromMap(Map<String, dynamic> map) {
    return Station(
      id: map['id']?.toInt(),
      station: map['station'] ?? '',
      code: map['code'] ?? '',
      imageURL: map['imageURL'] ?? '',
    );
  }


  String toJson() => json.encode(toMap());
  factory Station.fromJson(String source) =>
      Station.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Station(id: $id, station: $station, code: $code, imageURL: $imageURL)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Station &&
        other.id == id &&
        other.station == station &&
        other.code == code &&
        other.imageURL == imageURL;
  }
  @override
  int get hashCode {
    return id.hashCode ^ station.hashCode ^ code.hashCode ^ imageURL.hashCode;
  }
}
