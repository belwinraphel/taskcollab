import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';
import 'kanban_board_state.dart';

class KanbanBoardCubit extends Cubit<KanbanBoardState> {
  KanbanBoardCubit() : super(KanbanBoardState.initial());

  void zoomIn() {
    final newScale = (state.scale + 0.1).clamp(0.5, 2.0);
    _updateMatrix(newScale);
  }

  void zoomOut() {
    final newScale = (state.scale - 0.1).clamp(0.5, 2.0);
    _updateMatrix(newScale);
  }

  void resetZoom() {
    emit(KanbanBoardState.initial());
  }

  void onInteractionUpdate(double newScale, Matrix4 currentMatrix) {
    emit(state.copyWith(scale: newScale, matrix: currentMatrix));
  }

  void _updateMatrix(double newScale) {
    final translation = state.matrix.getTranslation();
    final newMatrix = Matrix4.identity()
      ..translateByDouble(translation.x, translation.y, 0.0, 1.0)
      ..scaleByDouble(newScale, newScale, newScale, 1.0);

    emit(KanbanBoardState(scale: newScale, matrix: newMatrix));
  }
}
