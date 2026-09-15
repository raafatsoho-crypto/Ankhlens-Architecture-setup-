// updated GlyphSymbol
class GlyphSymbol {
  final String unit;
  final String gardinerCode;
  final String assetPath;
  final double? widthRatio; // null = assume standard/wide, don't pair
  final String? note;

  const GlyphSymbol({
    required this.unit,
    required this.gardinerCode,
    required this.assetPath,
    this.widthRatio,
    this.note,
  });
}
// domain/services/horizontal_cartouche_layout.dart

class HorizontalCartoucheLayout implements CartoucheLayoutStrategy {
  static const double _unitSize = 40.0;

  @override
  CartoucheLayoutResult layout(List<GlyphSymbol> glyphs) {
    final positioned = <PositionedGlyph>[];
    double x = 0;
    for (final glyph in glyphs) {
      positioned.add(PositionedGlyph(
        glyph: glyph, x: x, y: 0, width: _unitSize, height: _unitSize,
      ));
      x += _unitSize;
    }
    return CartoucheLayoutResult(
      positioned: positioned,
      totalWidth: x,
      totalHeight: _unitSize,
    );
  }
}
// data/services/cartouche_renderer_impl.dart

class CartoucheRendererImpl {
  final CartoucheLayoutStrategy _layoutStrategy;

  CartoucheRendererImpl({CartoucheLayoutStrategy? layoutStrategy})
      : _layoutStrategy = layoutStrategy ?? VerticalStackedCartoucheLayout();

  /// Produces a ui.Image of the cartouche, including the enclosing
  /// oval/end-cap border, ready for PNG encoding.
  Future<ui.Image> render(List<GlyphSymbol> glyphs) async {
    final layout = _layoutStrategy.layout(glyphs);
    const padding = 24.0;
    final canvasWidth = layout.totalWidth + padding * 2;
    final canvasHeight = layout.totalHeight + padding * 2;

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    _drawCartoucheBorder(canvas, canvasWidth, canvasHeight);

    for (final pg in layout.positioned) {
      await _drawGlyph(canvas, pg, offsetX: padding + canvasWidth / 2, offsetY: padding);
    }

    final picture = recorder.endRecording();
    return picture.toImage(canvasWidth.ceil(), canvasHeight.ceil());
  }

  void _drawCartoucheBorder(Canvas canvas, double w, double h) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..color = const Color(0xFF3A2E1F);
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(2, 2, w - 4, h - 4),
      Radius.circular(w / 2),
    );
    canvas.drawRRect(rrect, paint);
  }

  Future<void> _drawGlyph(
    Canvas canvas,
    PositionedGlyph pg, {
    required double offsetX,
    required double offsetY,
  }) async {
    final image = await _loadGlyphImage(pg.glyph.assetPath);
    final destRect = Rect.fromLTWH(
      offsetX + pg.x, offsetY + pg.y, pg.width, pg.height,
    );
    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      destRect,
      Paint(),
    );
  }

  Future<ui.Image> _loadGlyphImage(String assetPath) async {
    final data = await rootBundle.load(assetPath);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    return frame.image;
  }
}
group('VerticalStackedCartoucheLayout', () {
  test('empty glyph list returns empty result', () { ... });
  test('single glyph occupies one row, centered', () { ... });
  test('two consecutive narrow glyphs are paired into one row', () { ... });
  test('wide glyph is never paired even if adjacent to narrow ones', () { ... });
  test('narrow glyph adjacent to wide glyph starts a new row, not paired', () { ... });
  test('glyph with null widthRatio is treated as wide (not paired)', () { ... });
  test('totalHeight scales with row count, not glyph count', () { ... });
  test('totalWidth reflects the widest row (paired row wider than single)', () { ... });
});

group('HorizontalCartoucheLayout', () {
  test('glyphs placed left-to-right with no vertical offset', () { ... });
  test('totalWidth scales linearly with glyph count', () { ... });
});
