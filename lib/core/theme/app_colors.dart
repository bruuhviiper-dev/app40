import 'package:flutter/material.dart';

/// Tokens de COR — tema NATALINO premium (verde-abeto profundo + vermelho-natal
/// + dourado quente). Nenhuma tela usa cor "solta"; sempre referenciar daqui.
/// Obs.: os tokens `gold*` mantêm o NOME do template premium, mas o VALOR aqui
/// é o acento vermelho-natal (toda a UI/botões/seleção muda de uma vez).
class AppColors {
  AppColors._();

  // Fundo (verde-abeto escuro)
  static const bg = Color(0xFF07190F); // fundo principal
  static const bg2 = Color(0xFF0C2418); // fundo secundário
  static const surface = Color(0xFF112E1C); // cards
  static const surfaceHigh = Color(0xFF164028); // superfície elevada

  // Marca (acento vermelho-natal — nome `gold` herdado do template)
  static const gold = Color(0xFFE8424E);
  static const goldDark = Color(0xFFC9303F);

  // Dourado quente de DETALHE (selos, estrelas, toques festivos)
  static const xmasGold = Color(0xFFF5C244);
  static const xmasGoldDark = Color(0xFFD9A52E);

  // Texto
  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFFC3D4C6);

  // Bordas
  static const border = Color(0xFF2A4A33);

  /// Pílula translúcida do acento (badge "MENSAGEM DO DIA").
  static Color get goldPill => gold.withValues(alpha: 0.16);

  /// Sobreposição branca em elementos sobre foto/gradiente.
  static Color get onPhotoSurface => Colors.white.withValues(alpha: 0.14);

  // ---- Tema CLARO (neve/creme) ----
  static const lBg = Color(0xFFFBF7F0);
  static const lBg2 = Color(0xFFF4EDE1);
  static const lSurface = Color(0xFFFFFFFF);
  static const lSurfaceHigh = Color(0xFFFDFAF4);
  static const lTextPrimary = Color(0xFF1D2A20);
  static const lTextSecondary = Color(0xFF5E6E62);
  static const lBorder = Color(0xFFE8E0D2);
}

/// Cores sensíveis ao TEMA (claro/escuro). As telas de "chrome" (fundos,
/// cartões sólidos, textos, nav) usam estas; as telas sobre FOTO usam branco
/// sobre scrim (iguais nos dois temas). O acento é o mesmo sempre.
class Palette {
  const Palette({
    required this.bg,
    required this.bg2,
    required this.surface,
    required this.surfaceHigh,
    required this.textPrimary,
    required this.textSecondary,
    required this.border,
  });

  final Color bg;
  final Color bg2;
  final Color surface;
  final Color surfaceHigh;
  final Color textPrimary;
  final Color textSecondary;
  final Color border;

  static const _dark = Palette(
    bg: AppColors.bg,
    bg2: AppColors.bg2,
    surface: AppColors.surface,
    surfaceHigh: AppColors.surfaceHigh,
    textPrimary: AppColors.textPrimary,
    textSecondary: AppColors.textSecondary,
    border: AppColors.border,
  );

  static const _light = Palette(
    bg: AppColors.lBg,
    bg2: AppColors.lBg2,
    surface: AppColors.lSurface,
    surfaceHigh: AppColors.lSurfaceHigh,
    textPrimary: AppColors.lTextPrimary,
    textSecondary: AppColors.lTextSecondary,
    border: AppColors.lBorder,
  );

  static Palette of(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? _dark : _light;
}
