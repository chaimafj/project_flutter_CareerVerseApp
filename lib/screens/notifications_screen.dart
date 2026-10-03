import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/l10n.dart';
import '../providers/app_state.dart';
import '../widgets/career_ui.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final notifications = state.notifications;
    final loc = context.l10n;

    return Scaffold(
      backgroundColor: canvas,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          loc.notifications,
          style: const TextStyle(color: ink, fontWeight: FontWeight.w800),
        ),
        actions: [
          if (state.unreadCount > 0)
            IconButton(
              tooltip: loc.markAllRead,
              onPressed: state.markAllRead,
              icon: const Icon(Icons.done_all),
            ),
          if (notifications.isNotEmpty)
            IconButton(
              tooltip: loc.clearAll,
              onPressed: state.clearNotifications,
              icon: const Icon(Icons.delete_sweep_outlined),
            ),
        ],
      ),
      body: notifications.isEmpty
          ? Center(
              child: EmptyState(
                icon: Icons.notifications_off_outlined,
                title: loc.noNotifications,
                message: loc.noNotificationsMessage,
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
                      loc.notificationTitle(n),
                      style: TextStyle(
                        color: ink,
                        fontWeight: n.read ? FontWeight.w600 : FontWeight.w800,
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Text(
                      '${loc.notificationBody(n)}\n${loc.timeAgo(n.createdAt)}',
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
