import 'dart:convert';

class BusTicket {
  final int? id;
  final DateTime departDate;
  final DateTime time;
  final String departStation;
  final String destStation;
  final int userId;
  BusTicket({
    this.id,
    required this.departDate,
    required this.time,
    this.departStation = '',
    this.destStation = '',
    this.userId = 0,
  });

  BusTicket copyWith({
    int? id,
    DateTime? departDate,
    DateTime? time,
    String? departStation,
    String? destStation,
    int? userId,
  }) {
    return BusTicket(
      id: id ?? this.id,
      departDate: departDate ?? this.departDate,
      time: time ?? this.time,
      departStation: departStation ?? this.departStation,
      destStation: destStation ?? this.destStation,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    // if (id != null) {
    //   result.addAll({'book_id': id});
    // }
    result.addAll({'depart_date': departDate.millisecondsSinceEpoch});
    result.addAll({'time': time.millisecondsSinceEpoch});
    result.addAll({'depart_station': departStation});
    result.addAll({'dest_station': destStation});
    result.addAll({'user_id': userId});

    return result;
  }

  factory BusTicket.fromMap(Map<String, dynamic> map) {
    return BusTicket(
      id: map['book_id']?.toInt(),
      departDate: DateTime.fromMillisecondsSinceEpoch(map['depart_date']),
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
      departStation: map['depart_station'] ?? '',
      destStation: map['dest_station'] ?? '',
      userId: map['user_id']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory BusTicket.fromJson(String source) =>
      BusTicket.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BusTicket(id: $id, departDate: $departDate, time: $time, departStation: $departStation, destStation: $destStation, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BusTicket &&
        other.id == id &&
        other.departDate == departDate &&
        other.time == time &&
        other.departStation == departStation &&
        other.destStation == destStation &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        departDate.hashCode ^
        time.hashCode ^
        departStation.hashCode ^
        destStation.hashCode ^
        userId.hashCode;
  }
}
