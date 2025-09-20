import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/sync_service.dart';
import '../../core/theme/app_text_styles.dart';

class NetworkStatusIndicator extends ConsumerWidget {
  const NetworkStatusIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syncService = ref.watch(syncServiceProvider);
    
    return StreamBuilder<bool>(
      stream: syncService.onlineStatusStream,
      builder: (context, snapshot) {
        final isOnline = snapshot.data ?? false;
        
        if (isOnline) {
          return const SizedBox.shrink();
        }
        
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.1),
            border: Border(
              bottom: BorderSide(
                color: Colors.orange.withOpacity(0.3),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.wifi_off,
                size: 16,
                color: Colors.orange[700],
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Mode hors ligne - Les données seront synchronisées quand vous serez reconnecté',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.orange[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SyncStatusIndicator extends ConsumerWidget {
  const SyncStatusIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syncService = ref.watch(syncServiceProvider);
    
    return StreamBuilder<bool>(
      stream: syncService.syncStatusStream,
      builder: (context, snapshot) {
        final isSyncing = snapshot.data ?? false;
        
        if (!isSyncing) {
          return const SizedBox.shrink();
        }
        
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            border: Border(
              bottom: BorderSide(
                color: Colors.blue.withOpacity(0.3),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[700]!),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Synchronisation en cours...',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.blue[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class NewGuidesNotification extends ConsumerWidget {
  const NewGuidesNotification({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syncService = ref.watch(syncServiceProvider);
    
    return StreamBuilder<List<Guide>>(
      stream: syncService.newGuidesStream,
      builder: (context, snapshot) {
        final newGuides = snapshot.data ?? [];
        
        if (newGuides.isEmpty) {
          return const SizedBox.shrink();
        }
        
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.green.withOpacity(0.3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.new_releases,
                    color: Colors.green[700],
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Nouveaux guides disponibles!',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: Colors.green[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                newGuides.length == 1
                    ? '${newGuides.first.title} est maintenant disponible'
                    : '${newGuides.length} nouveaux guides sont maintenant disponibles',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.green[700],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        // TODO: Naviguer vers les nouveaux guides
                      },
                      child: Text(
                        'Voir les guides',
                        style: TextStyle(color: Colors.green[700]),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Masquer la notification
                    },
                    child: Text(
                      'Masquer',
                      style: TextStyle(color: Colors.green[700]),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

// Provider pour le service de synchronisation
final syncServiceProvider = Provider<SyncService>((ref) {
  return SyncService();
});

// Widget principal qui combine tous les indicateurs
class StatusIndicators extends ConsumerWidget {
  const StatusIndicators({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: const [
        NetworkStatusIndicator(),
        SyncStatusIndicator(),
        NewGuidesNotification(),
      ],
    );
  }
}
