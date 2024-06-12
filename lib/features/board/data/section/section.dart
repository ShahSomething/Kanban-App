import 'package:equatable/equatable.dart';

class Section extends Equatable {
  final String id;
  final String projectId;
  final int order;
  final String name;

  const Section({
    required this.id,
    required this.projectId,
    required this.order,
    required this.name,
  });

  @override
  List<Object?> get props => [id, projectId, order, name];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'projectId': projectId,
      'order': order,
      'name': name,
    };
  }

  factory Section.fromMap(Map<String, dynamic> map) {
    return Section(
      id: map['id'] as String,
      projectId: map['project_id'] as String,
      order: map['order'] as int,
      name: map['name'] as String,
    );
  }
}
