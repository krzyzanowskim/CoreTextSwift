import CoreText
import Foundation

extension CTRun {

  public var glyphsCount: CFIndex {
    CTRunGetGlyphCount(self)
  }

  public func glyphs() -> [CGGlyph] {
    let runGlyphsCount = self.glyphsCount
    return [CGGlyph](unsafeUninitializedCapacity: runGlyphsCount) { (bufferPointer, count) in
      CTRunGetGlyphs(self, CFRange(), bufferPointer.baseAddress!)
      count = runGlyphsCount
    }
  }

  public func glyphsAdvances() -> [CGSize] {
    font.advances(of: glyphs())
  }

  public func typographicBounds() -> (ascent: CGFloat, descent: CGFloat, leading: CGFloat) {
    var ascent: CGFloat = 0
    var descent: CGFloat = 0
    var leading: CGFloat = 0
    CTRunGetTypographicBounds(self, CFRange(), &ascent, &descent, &leading)
    return (ascent: ascent, descent: descent, leading: leading)
  }

  public func baseAdvances() -> [CGSize] {
    let runGlyphsCount = self.glyphsCount
    return [CGSize](unsafeUninitializedCapacity: runGlyphsCount) { (bufferPointer, count) in
      CTRunGetBaseAdvancesAndOrigins(self, CFRange(), bufferPointer.baseAddress!, nil)
      count = runGlyphsCount
    }
  }

  public func baseOrigins() -> [CGPoint] {
    let runGlyphsCount = self.glyphsCount
    return [CGPoint](unsafeUninitializedCapacity: runGlyphsCount) { (bufferPointer, count) in
      CTRunGetBaseAdvancesAndOrigins(self, CFRange(), nil, bufferPointer.baseAddress!)
      count = runGlyphsCount
    }
  }

  /// The glyph positions in a run are relative to the origin of the line containing the run.
  public func glyphPositions() -> [CGPoint] {
    let runGlyphsCount = self.glyphsCount
    return [CGPoint](unsafeUninitializedCapacity: runGlyphsCount) { (bufferPointer, count) in
      CTRunGetPositions(self, CFRange(), bufferPointer.baseAddress!)
      count = runGlyphsCount
    }
  }

  public var attributes: [CTStringAttributeName: Any] {
    (CTRunGetAttributes(self) as NSDictionary as! [String: Any])
      .reduce([:]) { (partialResult: [CTStringAttributeName: Any], tuple: (key: String, value: Any)) in
        var result = partialResult
        if let attributeName = CTStringAttributeName(rawValue: tuple.key) {
          result[attributeName] = tuple.value
        }
        return result
    }
  }

  public var font: CTFont {
    attributes[.font] as! CTFont
  }

  public var foregroundColor: String? {
    attributes[.foregroundColor] as? String
  }

  public var runDelegate: Any? {
    attributes[.runDelegate]
  }
}

#if canImport(CoreGraphics)
extension CTRun {

  public func draw(range: CFRange = CFRange(), in context: CGContext) {
    CTRunDraw(self, context, range)
  }
}

extension CGContext {
  public func draw(_ run: CTRun) {
    run.draw(in: self)
  }
}
#endif
