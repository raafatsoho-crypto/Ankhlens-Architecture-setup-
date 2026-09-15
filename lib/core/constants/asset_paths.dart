/// Central bundled-asset path constants. No feature should build these
/// paths ad hoc — prevents typo-drift between features that share assets
/// (e.g. cartouche and dictionary both render glyph sprites).
abstract final class AssetPaths {
  static const String glyphsDir = 'assets/glyphs';
  static const String audioDir = 'assets/audio';
  static const String defaultBrandingDir = 'assets/branding';
  static const String localizationDir = 'assets/localization';

  static String glyphSprite(String gardinerCode) =>
      '$glyphsDir/$gardinerCode.webp';

  static String glyphAudio(String gardinerCode) =>
      '$audioDir/$gardinerCode.mp3';
}
