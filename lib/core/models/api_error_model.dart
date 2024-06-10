class ErrorModel {
  ErrorModel({
    required this.message,
    required this.name,
    required this.status,
  });

  factory ErrorModel.empty() => ErrorModel(
        message: '',
        name: '',
        status: -1,
      );

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        message: (json['message'] as String?) ?? '',
        name: (json['name'] as String?) ?? '',
        status: (json['status'] as int?) ?? -1,
      );
  final String message;
  final String name;
  final int status;

  Map<String, dynamic> toJson() => {
        'message': message,
        'name': name,
        'status': status,
      };
}
