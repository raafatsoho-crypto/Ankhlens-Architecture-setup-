// domain/entities/positioned_glyph.dart

class PositionedGlyph {
  final GlyphSymbol glyph;
  final double x;
  final double y;
  final double width;
  final double height;

  const PositionedGlyph({
    required this.glyph,
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });
}

class CartoucheLayoutResult {
  final List<PositionedGlyph> positioned;
  final double totalWidth;
  final double totalHeight;

  const CartoucheLayoutResult({
    required this.positioned,
    required this.totalWidth,
    required this.totalHeight,
  });
}
// domain/services/cartouche_layout_strategy.dart

abstract class CartoucheLayoutStrategy {
  /// Arranges glyphs into positioned coordinates within an abstract
  /// canvas (unit-agnostic; renderer scales to actual pixels).
  CartoucheLayoutResult layout(List<GlyphSymbol> glyphs);
}
// domain/services/vertical_stacked_cartouche_layout.dart

class VerticalStackedCartoucheLayout implements CartoucheLayoutStrategy {
  static const double _unitSize = 40.0;
  static const double _narrowThreshold = 0.6; // glyph width ratio considered "narrow"

  @override
  CartoucheLayoutResult layout(List<GlyphSymbol> glyphs) {
    if (glyphs.isEmpty) {
      return const CartoucheLayoutResult(
        positioned: [], totalWidth: 0, totalHeight: 0,
      );
    }

    final rows = _groupIntoRows(glyphs);
    final positioned = <PositionedGlyph>[];
    double y = 0;
    double maxRowWidth = 0;

    // Traditional cartouches read top-to-bottom; build rows then stack.
    for (final row in rows) {
      final rowWidth = row.length == 1 ? _unitSize : _unitSize * row.length;
      final startX = -rowWidth / 2; // centered around a vertical axis

      double x = startX;
      for (final glyph in row) {
        positioned.add(PositionedGlyph(
          glyph: glyph,
          x: x,
          y: y,
          width: _unitSize,
          height: _unitSize,
        ));
        x += _unitSize;
      }

      maxRowWidth = rowWidth > maxRowWidth ? rowWidth : maxRowWidth;
      y += _unitSize;
    }

    return CartoucheLayoutResult(
      positioned: positioned,
      totalWidth: maxRowWidth,
      totalHeight: y,
    );
  }

  /// Pairs consecutive "narrow" glyphs side-by-side within a single row,
  /// as traditional cartouches often do to save vertical space; wide
  /// glyphs occupy a row alone.
  List<List<GlyphSymbol>> _groupIntoRows(List<GlyphSymbol> glyphs) {
    final rows = <List<GlyphSymbol>>[];
    var i = 0;
    while (i < glyphs.length) {
      final current = glyphs[i];
      final isNarrow = _isNarrow(current);
      final hasNext = i + 1 < glyphs.length;
      final nextIsNarrow = hasNext && _isNarrow(glyphs[i + 1]);

      if (isNarrow && nextIsNarrow) {
        rows.add([current, glyphs[i + 1]]);
        i += 2;
      } else {
        rows.add([current]);
        i += 1;
      }
    }
    return rows;
  }

  bool _isNarrow(GlyphSymbol glyph) =>
      glyph.widthRatio != null && glyph.widthRatio! <= _narrowThreshold;
}
