import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';
import '../../l10n/strings.dart';

/// Contagem regressiva para o Natal (25/12) e o Ano Novo (01/01), lado a lado.
/// Diferencial da Home: cria urgência/clima festivo. Datas calculadas sempre
/// para a PRÓXIMA ocorrência (depois de 25/12 conta para o ano seguinte).
class CountdownCard extends StatelessWidget {
  const CountdownCard({super.key, this.onChristmas, this.onNewYear});

  /// Toques opcionais (abrem a categoria correspondente).
  final VoidCallback? onChristmas;
  final VoidCallback? onNewYear;

  /// Dias (em datas-calendário, ignorando hora) até a próxima ocorrência de
  /// [month]/[day]. 0 = é hoje.
  static int daysUntil(DateTime now, int month, int day) {
    final today = DateTime(now.year, now.month, now.day);
    var target = DateTime(now.year, month, day);
    if (target.isBefore(today)) target = DateTime(now.year + 1, month, day);
    return target.difference(today).inDays;
  }

  @override
  Widget build(BuildContext context) {
    final t = T.of(context);
    final now = DateTime.now();
    final xmas = daysUntil(now, 12, 25);
    final newYear = daysUntil(now, 1, 1);

    return Row(
      children: [
        Expanded(
          child: _CountdownTile(
            icon: LucideIcons.treePine,
            iconColor: AppColors.xmasGold,
            label: t.countdownChristmas,
            value: xmas == 0 ? t.countdownToday : t.countdownDays(xmas),
            highlight: xmas == 0,
            onTap: onChristmas,
          ),
        ),
        const SizedBox(width: AppSpacing.x3),
        Expanded(
          child: _CountdownTile(
            icon: LucideIcons.partyPopper,
            iconColor: AppColors.gold,
            label: t.countdownNewYear,
            value: newYear == 0 ? t.countdownToday : t.countdownDays(newYear),
            highlight: newYear == 0,
            onTap: onNewYear,
          ),
        ),
      ],
    );
  }
}

class _CountdownTile extends StatelessWidget {
  const _CountdownTile({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.highlight,
    this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final bool highlight;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return Material(
      color: p.surface,
      borderRadius: BorderRadius.circular(AppRadii.card),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.card),
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.x4, vertical: AppSpacing.x3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadii.card),
            border: Border.all(
                color: highlight ? iconColor : p.border, width: 1),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 20, color: iconColor),
              ),
              const SizedBox(width: AppSpacing.x3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.caption
                            .copyWith(color: p.textSecondary)),
                    const SizedBox(height: 2),
                    Text(value,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.body.copyWith(
                          color: p.textPrimary,
                          fontWeight: FontWeight.w800,
                          fontSize: 13.5,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
