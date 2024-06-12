import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final String id;
  final String taskId;
  final String content;
  final DateTime postedAt;

  const Comment({
    required this.id,
    required this.taskId,
    required this.content,
    required this.postedAt,
  });

  @override
  List<Object?> get props => [id, taskId, content, postedAt];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'task_id': taskId,
      'content': content,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'] as String,
      taskId: map['task_id'] as String,
      content: map['content'] as String,
      postedAt: DateTime.parse(map['posted_at'] as String),
    );
  }
}
