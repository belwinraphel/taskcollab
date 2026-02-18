import 'package:flutter/material.dart';
import 'package:task_collab_app/core/utils/constants.dart';
import 'package:task_collab_app/core/utils/helper.dart';

class TaskBoardHeader extends StatelessWidget {
  final String projectId;
  final String? projectName;
  final VoidCallback onAddMemberCheck;

  const TaskBoardHeader({
    super.key,
    required this.projectId,
    this.projectName,
    required this.onAddMemberCheck,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: KanbanConstants.headerBorder)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left,
                    color: KanbanConstants.iconBlue),
                onPressed: () => Navigator.pop(context),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "${getShortProjectId(projectId)} - ",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: KanbanConstants.cardTitle,
                          ),
                        ),
                        TextSpan(
                          text: projectName ?? 'Project',
                          style: const TextStyle(
                            overflow: TextOverflow.clip,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: KanbanConstants.cardTitle,
                          ),
                        ),
                      ],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Text(
                    "PHASE HA1 - FIRST AC IMPLEMENTATION",
                    style: TextStyle(
                      overflow: TextOverflow.clip,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: KanbanConstants.phaseText,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.person_add, color: KanbanConstants.iconBlue),
            onPressed: onAddMemberCheck,
          ),
        ],
      ),
    );
  }
}
