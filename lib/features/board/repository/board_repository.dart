import 'package:dartz/dartz.dart';
import 'package:kanban/core/errors/failures.dart';
import 'package:kanban/features/board/data/board_task/board_task.dart';
import 'package:kanban/features/board/data/comment/comment.dart';
import 'package:kanban/features/board/data/section/section.dart';

abstract class BoardRepository {
  Future<Either<Failure, List<Section>>> getAllSections(String projectId);

  Future<Either<Failure, List<BoardTask>>> getActiveTasks(String projectId);

  Future<Either<Failure, BoardTask>> createTask(BoardTask task);

  Future<Either<Failure, BoardTask>> updateTask(
      String taskId, Map<String, dynamic> params);

  Future<Either<Failure, void>> closeTask(String taskId);

  // Future<void> deleteTask(String taskId);

  Future<Either<Failure, List<Comment>>> getAllComments(String taskId);

  Future<Either<Failure, Comment>> createComment(Comment comment);

  // Future<void> deleteComment(String commentId);

  Future<Either<Failure, void>> updateComment(String commentId, String content);
}
