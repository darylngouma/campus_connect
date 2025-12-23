import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../data/models/course_session_model.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../providers/session_provider.dart';
import '../../widgets/modern_card.dart';
import '../../widgets/app_bar_with_actions.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SessionProvider>(context, listen: false).loadMySchedule();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBarWithActions(
        title: 'Emploi du temps',
        additionalActions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Actualiser',
            onPressed: () {
              Provider.of<SessionProvider>(context, listen: false).loadMySchedule();
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Provider.of<SessionProvider>(context, listen: false).loadMySchedule();
        },
        child: Consumer<SessionProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading && provider.sessions.isEmpty) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              );
            }

            if (provider.errorMessage != null && provider.sessions.isEmpty) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline_rounded,
                          size: 64,
                          color: AppColors.error,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          provider.errorMessage!,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.error,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: () => provider.loadMySchedule(),
                          icon: const Icon(Icons.refresh_rounded),
                          label: const Text('Réessayer'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            if (provider.sessions.isEmpty) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 80,
                          color: AppColors.textTertiary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Aucune session prévue',
                          style: AppTextStyles.headlineSmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            // Grouper les sessions par date
            final groupedSessions = <DateTime, List<CourseSessionModel>>{};
            for (var session in provider.sessions) {
              final date = DateTime(session.date.year, session.date.month, session.date.day);
              groupedSessions.putIfAbsent(date, () => []).add(session);
            }

            final sortedDates = groupedSessions.keys.toList()..sort();

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: sortedDates.length,
              itemBuilder: (context, index) {
                final date = sortedDates[index];
                final sessions = groupedSessions[date]!;
                
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 12, top: index > 0 ? 24 : 0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              DateFormat('EEEE d MMMM yyyy', 'fr_FR').format(date),
                              style: AppTextStyles.titleMedium.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ...sessions.map((session) => ModernCard(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Icône de type de session
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: _getSessionTypeColor(session.sessionType).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              _getSessionTypeIcon(session.sessionType),
                              color: _getSessionTypeColor(session.sessionType),
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Informations de la session
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  session.moduleCode ?? session.moduleName ?? '',
                                  style: AppTextStyles.titleLarge,
                                ),
                                if (session.moduleName != null && session.moduleName != session.moduleCode)
                                  Text(
                                    session.moduleName!,
                                    style: AppTextStyles.bodySmall,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time_rounded,
                                      size: 16,
                                      color: AppColors.textSecondary,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${session.startTime.substring(0, 5)} - ${session.endTime.substring(0, 5)}',
                                      style: AppTextStyles.bodySmall.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                if (session.location != null) ...[
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        size: 16,
                                        color: AppColors.textSecondary,
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          session.location!,
                                          style: AppTextStyles.bodySmall,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),
                          // Badge en ligne
                          if (session.isOnline)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.accent.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.videocam_rounded,
                                    size: 14,
                                    color: AppColors.accent,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'En ligne',
                                    style: AppTextStyles.labelSmall.copyWith(
                                      color: AppColors.accent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    )),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Color _getSessionTypeColor(String type) {
    switch (type) {
      case 'exam':
        return AppColors.error;
      case 'lecture':
        return AppColors.primary;
      case 'tutorial':
        return AppColors.success;
      case 'lab':
        return AppColors.warning;
      default:
        return AppColors.textTertiary;
    }
  }

  IconData _getSessionTypeIcon(String type) {
    switch (type) {
      case 'exam':
        return Icons.assignment_outlined;
      case 'lecture':
        return Icons.school_outlined;
      case 'tutorial':
        return Icons.groups_outlined;
      case 'lab':
        return Icons.science_outlined;
      default:
        return Icons.event_outlined;
    }
  }
}
