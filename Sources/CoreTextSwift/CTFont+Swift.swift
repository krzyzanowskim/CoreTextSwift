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

  public func advances(of glyphs: [CGGlyph], orientation: CTFontOrientation = .default) -> [CGSize] {
    glyphs.advances(for: self, orientation: orientation)
  }

  public func boundingBox() -> CGRect {
    CTFontGetBoundingBox(self)
  }

  public func boundingRects(of glyphs: [CGGlyph], orientation: CTFontOrientation = .default) -> [CGRect] {
    glyphs.boundingRects(for: self, orientation: orientation)
  }

  public func opticalBounds(of glyphs: [CGGlyph]) -> [CGRect] {
    glyphs.opticalBounds(for: self)
  }

  public func totalAdvance(of glyphs: [CGGlyph]) -> Double {
    advances(of: glyphs).reduce(0, { $0 + Double($1.width) })
  }

  public func path(for glyph: CGGlyph, transform: CGAffineTransform = .identity) -> CGPath? {
    var transform = transform
    return CTFontCreatePathForGlyph(self, glyph, &transform)
  }

  public func glyphCount() -> CFIndex {
    CTFontGetGlyphCount(self)
  }
}
