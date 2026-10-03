import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_state.dart';
import '../widgets/career_ui.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final notifications = state.notifications;

    return Scaffold(
      backgroundColor: canvas,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text(
          'Notifications',
          style: TextStyle(color: ink, fontWeight: FontWeight.w800),
        ),
        actions: [
          if (state.unreadCount > 0)
            IconButton(
              tooltip: 'Mark all as read',
              onPressed: state.markAllRead,
              icon: const Icon(Icons.done_all),
            ),
          if (notifications.isNotEmpty)
            IconButton(
              tooltip: 'Clear all',
              onPressed: state.clearNotifications,
              icon: const Icon(Icons.delete_sweep_outlined),
            ),
        ],
      ),
      body: notifications.isEmpty
          ? const Center(
              child: EmptyState(
                icon: Icons.notifications_off_outlined,
                title: 'No notifications',
                message:
                    'You will be notified when your lab results and '
                    'recommendations are ready.',
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              separatorBuilder: (_, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final n = notifications[index];
                return Material(
                  color: n.read ? Colors.white : const Color(0xFFF3F0FF),
                  borderRadius: BorderRadius.circular(14),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    onTap: () {
                      state.markRead(n.id);
                      if (n.resultId != null &&
                          state.resultById(n.resultId!) != null) {
                        Navigator.of(context)
                            .pushNamed('/results', arguments: n.resultId);
                      }
                    },
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFFEDE8FF),
                      child: Icon(
                        n.resultId != null
                            ? Icons.auto_awesome
                            : Icons.notifications_active_outlined,
                        color: purple,
                      ),
                    ),
                    title: Text(
                      n.title,
                      style: TextStyle(
                        color: ink,
                        fontWeight: n.read ? FontWeight.w600 : FontWeight.w800,
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Text(
                      '${n.body}\n${timeAgo(n.createdAt)}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    isThreeLine: true,
                    trailing: n.read
                        ? null
                        : const CircleAvatar(
                            radius: 5,
                            backgroundColor: purple,
                          ),
                  ),
                );
              },
            ),
    );
  }
}
