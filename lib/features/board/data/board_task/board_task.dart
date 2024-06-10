import 'package:equatable/equatable.dart';

class BoardTask extends Equatable {
  final String id;
  final String projectId;
  final String parentId;
  final String content;
  final String description;
  final DateTime dueDate;
  final DateTime createdAt;
  final int commentsCount;
  final bool isCompleted;
  final Duration? duration;
  final List<String> labels;
  final int priority;
  const BoardTask({
    required this.id,
    required this.projectId,
    required this.parentId,
    required this.content,
    required this.description,
    required this.dueDate,
    required this.createdAt,
    required this.commentsCount,
    required this.isCompleted,
    required this.labels,
    required this.priority,
    this.duration,
  });

  BoardTask copyWith({
    String? id,
    String? projectId,
    String? parentId,
    String? content,
    String? description,
    DateTime? dueDate,
    DateTime? createdAt,
    int? commentsCount,
    bool? isCompleted,
    Duration? duration,
    List<String>? labels,
    int? priority,
  }) {
    return BoardTask(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      parentId: parentId ?? this.parentId,
      content: content ?? this.content,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      createdAt: createdAt ?? this.createdAt,
      commentsCount: commentsCount ?? this.commentsCount,
      isCompleted: isCompleted ?? this.isCompleted,
      duration: duration ?? this.duration,
      labels: labels ?? this.labels,
      priority: priority ?? this.priority,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'project_id': projectId,
      'parent_id': parentId,
      'content': content,
      'description': description,
      'due_date': dueDate.millisecondsSinceEpoch,
      'created_at': createdAt.millisecondsSinceEpoch,
      'comments_count': commentsCount,
      'is_completed': isCompleted,
      'duration': duration,
      'labels': labels,
      'priority': priority,
    };
  }

  factory BoardTask.fromMap(Map<String, dynamic> map) {
    return BoardTask(
      id: map['id'] as String,
      projectId: map['project_id'] as String,
      parentId: map['parent_id'] as String,
      content: map['content'] as String,
      description: map['description'] as String,
      dueDate: DateTime.parse(map['due']['datetime'] as String),
      createdAt: DateTime.parse(map['created_at'] as String),
      commentsCount: map['comments_count'] as int,
      isCompleted: map['is_completed'] as bool,
      // duration: Duration.fromMap(map['duration'] as Map<String,dynamic>),
      labels: List<String>.from(
        (map['labels'] as List<String>),
      ),
      priority: map['priority'] as int,
    );
  }

  @override
  List<Object?> get props => [
        id,
        projectId,
        parentId,
        content,
        description,
        dueDate,
        createdAt,
        commentsCount,
        isCompleted,
        duration,
        labels,
        priority,
      ];
}
