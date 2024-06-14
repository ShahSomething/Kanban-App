import 'package:dartz/dartz.dart';
import 'package:kanban/core/errors/failures.dart';
import 'package:kanban/features/board/data/board_task/board_task.dart';
import 'package:kanban/features/board/data/comment/comment.dart';
import 'package:kanban/features/board/data/section/section.dart';
import 'package:kanban/features/board/datasource/board_data_source.dart';
import 'package:kanban/features/board/repository/board_repository.dart';

class BoardRepositoryImpl implements BoardRepository {
  final BoardDataSource _dataSource;
  BoardRepositoryImpl({required BoardDataSource boardDataSource})
      : _dataSource = boardDataSource;

  @override
  Future<Either<Failure, void>> closeTask(String taskId) async {
    try {
      final result = await _dataSource.closeTask(taskId);
      return Right(result);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Comment>> createComment(Comment comment) async {
    try {
      final result = await _dataSource.createComment(comment);
      return Right(result);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BoardTask>> createTask(BoardTask task) async {
    try {
      final result = await _dataSource.createTask(task);
      return Right(result);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BoardTask>>> getActiveTasks(
      String projectId) async {
    try {
      final result = await _dataSource.getActiveTasks(projectId);
      return Right(result);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Comment>>> getAllComments(String taskId) async {
    try {
      final result = await _dataSource.getAllComments(taskId);
      return Right(result);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Section>>> getAllSections(
      String projectId) async {
    try {
      final result = await _dataSource.getAllSections(projectId);
      return Right(result);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateComment(
      String commentId, String content) async {
    try {
      final result = await _dataSource.updateComment(commentId, content);
      return Right(result);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BoardTask>> updateTask(
      String taskId, Map<String, dynamic> params) async {
    try {
      final result = await _dataSource.updateTask(taskId, params);
      return Right(result);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
