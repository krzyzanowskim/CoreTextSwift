import Foundation
import CoreText

extension CTLine {

  public enum LineHeight {
    case typographic
    case normal // +20%
  }

  public func glyphRuns() -> [CTRun] {
    CTLineGetGlyphRuns(self) as! [CTRun]
  }

  public func typographicBounds() -> (ascent: CGFloat, descent: CGFloat, leading: CGFloat) {
    var ascent: CGFloat = 0
    var descent: CGFloat = 0
    var leading: CGFloat = 0
    CTLineGetTypographicBounds(self, &ascent, &descent, &leading)
    return (ascent: ascent, descent: descent, leading: leading)
  }

  public func typographicHeight() -> CGFloat {
    let (ascent, descent, leading) = typographicBounds()
    return ascent + descent + leading
  }

  public func height(_ kind: LineHeight = .typographic) -> CGFloat {
    let (ascent, descent, leading) = typographicBounds()

    switch kind {
      case .typographic:
        return ascent + descent + leading
      case .normal:
        // 1.20 factor does not perfectly gives CoreText value, but this is the factor in general
        return floor((ascent + descent + leading) * 1.20)
    }
  }

  /// Performs hit testing.
  public func characterIndex(forPosition position: CGPoint) -> CFIndex {
    CTLineGetStringIndexForPosition(self, position)
  }

  /// Offset for character Index (Index is frame string index, not line index)
  public func offsetForCharacterIndex(_ characterIndex: CFIndex) -> CGFloat {
    CTLineGetOffsetForStringIndex(self, characterIndex, nil)
  }

  public func stringRange() -> NSRange {
    NSRange(CTLineGetStringRange(self))
  }

  /// The provided block is invoked once for each logical caret edge in the line, in left-to-right visual order.
  private func carretOffsets(offset: @escaping (_ offset: Double, _ charIndex: CFIndex) -> Void) {
    // The offset parameter is relative to the line origin
    CTLineEnumerateCaretOffsets(self) { offsetValue, charIndex, leadingEdge, stop  in
      offset(offsetValue, charIndex)
      // stop.pointee = true
    }
  }

  public func carretOffsets() -> [Double] {
    var offsets: [Double] = []
    offsets.reserveCapacity(300)
    carretOffsets { (offset, charIndex) in
      offsets += [offset]
    }
    return offsets
  }
}

#if canImport(CoreGraphics)
extension CTLine {

  public func imageBounds(in context: CGContext) -> CGRect {
    CTLineGetImageBounds(self, context)
  }

  public func draw(in context: CGContext) {
    CTLineDraw(self, context)
  }
}

extension CGContext {
  public func draw(_ line: CTLine) {
    line.draw(in: self)
  }
}
#endif
