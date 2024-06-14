import 'package:kanban/features/board/data/board_task/board_task.dart';
import 'package:kanban/features/board/data/comment/comment.dart';
import 'package:kanban/features/board/data/section/section.dart';

abstract class BoardDataSource {
  Future<List<Section>> getAllSections(String projectId);

  Future<List<BoardTask>> getActiveTasks(String projectId);

  Future<BoardTask> createTask(BoardTask task);

  Future<BoardTask> updateTask(String taskId, Map<String, dynamic> params);

  Future<void> closeTask(String taskId);

  // Future<void> deleteTask(String taskId);

  Future<List<Comment>> getAllComments(String taskId);

  Future<Comment> createComment(Comment comment);

  // Future<void> deleteComment(String commentId);

  Future<void> updateComment(String commentId, String content);
}
