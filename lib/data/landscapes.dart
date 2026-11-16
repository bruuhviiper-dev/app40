/// Fundos temáticos de Natal e Ano Novo (offline). Fotos reais do Pexels —
/// Licença Pexels, uso comercial permitido (ver assets/landscapes/
/// ATTRIBUTIONS.md). Organizados por TEMA para o editor. Fallback elegante
/// quando uma imagem não existir é tratado nos widgets (gradiente + ícone).
class Landscapes {
  Landscapes._();

  static const _p = 'assets/landscapes/';

  static const hero = '${_p}hero_sunrise.jpg';
  static const onboarding = '${_p}onboarding.jpg';

  static const inspiration = <String>[
    '${_p}insp_peak.jpg',
    '${_p}insp_coast.jpg',
    '${_p}insp_lake.jpg',
  ];

  static String inspThumb(int i) => inspiration[i % inspiration.length];

  /// Fundos agrupados por TEMA (a chave é só organizacional; o editor usa a
  /// lista achatada [editorBackgrounds]).
  static const themes = <String, List<String>>{
    'lights': [
      '${_p}cat_boas_festas.jpg',
      '${_p}bg_bokeh_red.jpg',
      '${_p}bg_bokeh_warm.jpg',
      '${_p}bg_bokeh_pink.jpg',
      hero,
    ],
    'tree': [
      '${_p}editor_bg01.jpg',
      '${_p}cat_natal.jpg',
      '${_p}cat_engracadas.jpg',
      '${_p}bg_branch_bow.jpg',
      onboarding,
    ],
    'snow': [
      '${_p}insp_peak.jpg',
      '${_p}insp_lake.jpg',
      '${_p}editor_bg02.jpg',
      '${_p}editor_bg06.jpg',
      '${_p}bg_tree_snowy.jpg',
      '${_p}bg_frosted_tree.jpg',
      '${_p}bg_winter_pines.jpg',
    ],
    'candles': [
      '${_p}cat_familia.jpg',
      '${_p}cat_religiosas.jpg',
      '${_p}cat_gratidao.jpg',
      '${_p}editor_bg04.jpg',
      '${_p}bg_candles_ribbons.jpg',
    ],
    'fireworks': [
      '${_p}cat_ano_novo.jpg',
      '${_p}insp_coast.jpg',
      '${_p}editor_bg03.jpg',
      '${_p}bg_fireworks_water.jpg',
    ],
    'celebration': [
      '${_p}cat_amigos.jpg',
      '${_p}cat_reveillon.jpg',
      '${_p}cat_amor.jpg',
      '${_p}cat_clientes_trabalho.jpg',
      '${_p}cat_prosperidade.jpg',
      '${_p}editor_bg05.jpg',
      '${_p}editor_bg07.jpg',
      '${_p}editor_bg08.jpg',
      '${_p}bg_gifts_tree.jpg',
    ],
  };

  /// Todos os fundos do EDITOR, na ordem dos temas (achatado).
  static final List<String> editorBackgrounds = [
    for (final list in themes.values) ...list,
  ];

  /// Índice (em [editorBackgrounds]) de um fundo que combina com a categoria.
  static int editorIndexForCategory(String categoryId) {
    final asset = '${_p}cat_$categoryId.jpg';
    final i = editorBackgrounds.indexOf(asset);
    return i < 0 ? 0 : i;
  }
}
