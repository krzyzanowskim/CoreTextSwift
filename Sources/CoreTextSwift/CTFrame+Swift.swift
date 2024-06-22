import CoreText
import Foundation

extension CTFrame {
  /// Returns an array of lines stored in the frame.
  public func lines() -> [CTLine] {
    CTFrameGetLines(self) as? [CTLine] ?? []
  }

  /// Copies a range of line origins for a frame.
  /// - Parameter range: The range of line origins.
  /// - Returns: Each CGPoint in this array is the origin of the corresponding line in the array of lines returned by lines()
  ///            relative to the origin of the path's bounding box, which can be obtained from CGPath.boundingBoxOfPath.
  public func lineOrigins(range: NSRange = NSRange()) -> [CGPoint] {
    let linesCount = lines().count
    return [CGPoint](unsafeUninitializedCapacity: linesCount) { (bufferPointer, count) in
      CTFrameGetLineOrigins(self, CFRange(range), bufferPointer.baseAddress!)
      count = linesCount
    }
  }

  /// Returns the path used to create the frame.
  public func path() -> CGPath {
    CTFrameGetPath(self)
  }

  /// Returns the range of characters that actually fit in the frame.
  public func visibleStringRange() -> NSRange {
    NSRange(CTFrameGetVisibleStringRange(self))
  }

  /// Returns the range of characters originally requested to fill the frame.
  public func stringRange() -> NSRange {
    NSRange(CTFrameGetStringRange(self))
  }
}

#if canImport(CoreGraphics)
extension CTFrame {
  public func draw(in context: CGContext) {
    CTFrameDraw(self, context)
  }
}

extension CGContext {
  public func draw(_ frame: CTFrame) {
    frame.draw(in: self)
  }
}
#endif

