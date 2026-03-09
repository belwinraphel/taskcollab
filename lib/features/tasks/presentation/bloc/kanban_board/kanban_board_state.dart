import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class KanbanBoardState extends Equatable {
  final double scale;
  final Matrix4 matrix;

  const KanbanBoardState({required this.scale, required this.matrix});

  factory KanbanBoardState.initial() {
    final initialScale = 0.5;
    final initialMatrix = Matrix4.identity()
      ..scaleByDouble(initialScale, initialScale, initialScale, 1.0);
    return KanbanBoardState(scale: initialScale, matrix: initialMatrix);
  }

  KanbanBoardState copyWith({double? scale, Matrix4? matrix}) {
    return KanbanBoardState(
      scale: scale ?? this.scale,
      matrix: matrix ?? this.matrix,
    );
  }

  @override
  List<Object> get props => [scale, matrix];
}
