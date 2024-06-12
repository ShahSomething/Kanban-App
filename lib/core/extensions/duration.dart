extension DurationExtension on Duration {
  Map<String, dynamic> toMap() {
    if (inSeconds < 60) {
      return <String, dynamic>{
        'amount': inSeconds,
        'unit': 'second',
      };
    } else if (inMinutes < 60) {
      return <String, dynamic>{
        'amount': inMinutes,
        'unit': 'minute',
      };
    } else {
      return <String, dynamic>{
        'amount': inHours,
        'unit': 'hour',
      };
    }
  }

  static Duration fromMap(Map<String, dynamic> map) {
    final amount = map['amount'] as int;
    final unit = map['unit'] as String;
    switch (unit) {
      case 'second':
        return Duration(seconds: amount);
      case 'minute':
        return Duration(minutes: amount);
      case 'hour':
        return Duration(hours: amount);
      default:
        throw UnimplementedError();
    }
  }

  int get duration {
    if (inSeconds < 60) {
      return inSeconds;
    } else if (inMinutes < 60) {
      return inMinutes;
    } else {
      return inHours;
    }
  }

  String get unit {
    if (inSeconds < 60) {
      return 'second';
    } else if (inMinutes < 60) {
      return 'minute';
    } else {
      return 'hour';
    }
  }
}
