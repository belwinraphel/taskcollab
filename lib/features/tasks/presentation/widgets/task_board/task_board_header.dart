import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../projects/presentation/bloc/projects_bloc.dart';
import '../../../../projects/presentation/bloc/projects_state.dart';

class TaskBoardHeader extends StatelessWidget {
  final String projectId;

  const TaskBoardHeader({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 48, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: BlocBuilder<ProjectsBloc, ProjectsState>(
                  builder: (context, state) {
                    final project = state.maybeWhen(
                      loaded: (projects) => projects.firstWhere(
                        (p) => p.id == projectId,
                        orElse: () => throw Exception('Project not found'),
                      ),
                      orElse: () => null,
                    );

                    if (project == null) {
                      return const SizedBox.shrink();
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          project.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    );
                  },
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                    color: Colors.grey[600],
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    onPressed: () {},
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 8),
                  const CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(
                        'https://i.pravatar.cc/150?u=a042581f4e29026024d'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
