import 'package:equatable/equatable.dart';
import 'package:kanban/core/extensions/duration.dart';

class BoardTask extends Equatable {
  final String id;
  final String projectId;
  final String? parentId;
  final String sectionId;
  final String content;
  final String description;
  final DateTime? dueDate;
  final DateTime createdAt;
  final int commentsCount;
  final bool isCompleted;
  final Duration? duration;
  final List<String> labels;
  final int priority;
  const BoardTask({
    required this.id,
    required this.projectId,
    this.parentId,
    required this.sectionId,
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
    String? sectionId,
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
      sectionId: sectionId ?? this.sectionId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'project_id': projectId,
      'section_id': sectionId,
      'content': content,
      'description': description,
      'due_datetime': dueDate?.toIso8601String(),
      'duration': duration?.duration,
      "duration_unit": duration?.unit,
      'labels': labels,
      'priority': priority,
    };
  }

  factory BoardTask.fromMap(Map<String, dynamic> map) {
    return BoardTask(
      id: map['id'] as String,
      projectId: map['project_id'] as String,
      parentId: map['parent_id'],
      content: map['content'] as String,
      description: map['description'] as String,
      dueDate: DateTime.parse(map['due']['datetime'] as String),
      createdAt: DateTime.parse(map['created_at'] as String),
      commentsCount: map['comments_count'] as int,
      isCompleted: map['is_completed'] as bool,
      duration:
          DurationExtension.fromMap(map['duration'] as Map<String, dynamic>),
      labels: List<String>.from(
        (map['labels'] as List<String>),
      ),
      priority: map['priority'] as int,
      sectionId: map['section_id'] as String,
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
        sectionId,
      ];
}
