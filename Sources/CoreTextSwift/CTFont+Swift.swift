import CoreText
import Foundation

extension CTFont {

  public func size() -> CGFloat {
    CTFontGetSize(self)
  }

  public func slantAngle() -> CGFloat {
    CTFontGetSlantAngle(self)
  }

  public func xHeight() -> CGFloat {
    CTFontGetXHeight(self)
  }

  public func capHeight() -> CGFloat {
    CTFontGetCapHeight(self)
  }

  public func leading() -> CGFloat {
    CTFontGetLeading(self)
  }

  public func descent() -> CGFloat {
    CTFontGetDescent(self)
  }

  public func ascent() -> CGFloat {
    CTFontGetAscent(self)
  }

  /// Returns the number of glyphs of the given font.
  public var glyphCount: CFIndex {
    CTFontGetGlyphCount(self)
  }

  /// Calculates the advances for an array of glyphs and returns the summed advance.
  public func advances(of glyphs: [CGGlyph], orientation: CTFontOrientation = .default) -> [CGSize] {
    glyphs.advances(for: self, orientation: orientation)
  }

  public func boundingBox() -> CGRect {
    CTFontGetBoundingBox(self)
  }

  public func boundingRects(of glyphs: [CGGlyph], orientation: CTFontOrientation = .default) -> [CGRect] {
    glyphs.boundingRects(for: self, orientation: orientation)
  }

  /// Calculates the optical bounds for an array of glyphs and returns the overall optical bounds for the run.
  public func opticalBounds(of glyphs: [CGGlyph]) -> [CGRect] {
    glyphs.opticalBounds(for: self)
  }

  /// Calculates the summed advance of glyphs
  public func totalAdvance(of glyphs: [CGGlyph]) -> Double {
    advances(of: glyphs).reduce(0, { $0 + Double($1.width) })
  }

  /// Creates a path for the specified glyph.
  public func path(for glyph: CGGlyph, transform: CGAffineTransform = .identity) -> CGPath? {
    var transform = transform
    return CTFontCreatePathForGlyph(self, glyph, &transform)
  }
}

#if canImport(CoreGraphics)
extension CTFont {

  public func draw(glyphs: [CGGlyph], at positions: [CGPoint], in context: CGContext) {
    var glyphs = glyphs
    var positions = positions
    CTFontDrawGlyphs(self, &glyphs, &positions, glyphs.count, context)
  }
}
#endif
