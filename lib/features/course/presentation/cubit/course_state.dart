import 'package:codemap2/features/course/domain/entities/course.dart';
import 'package:equatable/equatable.dart';


abstract class CourseState extends Equatable {
  const CourseState();

  @override
  List<Object?> get props => [];
}

class CourseInitial extends CourseState {}

class CourseLoading extends CourseState {}

class CourseLoaded extends CourseState {
  final List<Course> courses;
  final CourseCategory category;
  final String query;

  const CourseLoaded({
    required this.courses,
    required this.category,
    this.query = '',
  });

  @override
  List<Object?> get props => [courses, category, query];
}

class CourseError extends CourseState {
  final String message;
  const CourseError(this.message);

  @override
  List<Object?> get props => [message];
}
