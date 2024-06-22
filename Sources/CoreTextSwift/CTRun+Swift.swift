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

  /// Returns the run's status.
  public var status: CTRunStatus {
    CTRunGetStatus(self)
  }

  /// String indices stored in the run
  ///
  /// The indices are the character indices that originally spawned the glyphs that make up the run.
  /// They can be used to map the glyphs in the run back to the characters in the backing store.
  public func stringIndices(in range: NSRange = NSRange()) -> [CFIndex] {
    let runGlyphsCount = self.glyphsCount
    return [CFIndex](unsafeUninitializedCapacity: runGlyphsCount) { (bufferPointer, count) in
      CTRunGetStringIndices(self, CFRange(range), bufferPointer.baseAddress!)
      count = runGlyphsCount
    }
  }

  /// Gets the range of characters that originally spawned the glyphs in the run.
  public var stringRange: NSRange {
    NSRange(CTRunGetStringRange(self))
  }
}

#if canImport(CoreGraphics)
extension CTRun {

  /// Draws a complete run or part of one.
  public func draw(range: CFRange = CFRange(), in context: CGContext) {
    CTRunDraw(self, context, range)
  }

  /// Returns the text matrix needed to draw this run.
  public var textMatrix: CGAffineTransform {
    CTRunGetTextMatrix(self)
  }
}

extension CGContext {

  /// Draws a complete run or part of one.
  public func draw(_ run: CTRun) {
    run.draw(in: self)
  }

}
#endif
