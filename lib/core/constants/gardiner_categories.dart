/// Gardiner sign-list categories (A–Z, Aa) used across scanner,
/// dictionary, and cartouche features. This enum is the single source
/// of truth — no feature should hardcode category strings.
enum GardinerCategory {
  a('A', 'Man and his occupations'),
  b('B', 'Woman and her occupations'),
  c('C', 'Anthropomorphic deities'),
  d('D', 'Parts of the human body'),
  e('E', 'Mammals'),
  f('F', 'Parts of mammals'),
  g('G', 'Birds'),
  h('H', 'Parts of birds'),
  i('I', 'Amphibious animals, reptiles'),
  k('K', 'Fish and parts of fish'),
  l('L', 'Invertebrates and lesser animals'),
  m('M', 'Trees and plants'),
  n('N', 'Sky, earth, water'),
  o('O', 'Buildings, parts of buildings'),
  p('P', 'Ships and parts of ships'),
  q('Q', 'Domestic and funerary furniture'),
  r('R', 'Temple furniture and sacred emblems'),
  s('S', 'Crowns, dress, staves'),
  t('T', 'Warfare, hunting, butchery'),
  u('U', 'Agriculture, crafts, professions'),
  v('V', 'Rope, fiber, baskets, bags'),
  w('W', 'Vessels of stone and earthenware'),
  x('X', 'Loaves and cakes'),
  y('Y', 'Writings, games, music'),
  z('Z', 'Strokes, geometrical figures'),
  aa('Aa', 'Unclassified');

  final String code;
  final String description;
  const GardinerCategory(this.code, this.description);

  static GardinerCategory fromCode(String code) => GardinerCategory.values
      .firstWhere((c) => c.code.toLowerCase() == code.toLowerCase(),
          orElse: () => GardinerCategory.aa);
}
