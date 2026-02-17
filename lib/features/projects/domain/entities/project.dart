import 'package:equatable/equatable.dart';

class Project extends Equatable {
  final String id;
  final String name;
  final String description;
  final String ownerId;
  final List<String> memberIds;
  final DateTime? createdAt;

  const Project({
    required this.id,
    required this.name,
    required this.description,
    required this.ownerId,
    required this.memberIds,
    required this.createdAt,
  });

  @override
  List<Object?> get props =>
      [id, name, description, ownerId, memberIds, createdAt];
}
