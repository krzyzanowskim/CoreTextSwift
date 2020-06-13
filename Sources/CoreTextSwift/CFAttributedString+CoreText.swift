import CoreText

extension CFAttributedString {

  /// Creates a single immutable line object directly from an attributed string.
  public func line() -> CTLine {
    CTLineCreateWithAttributedString(self)
  }

  /// Creates an immutable framesetter object from an attributed string.
  public func framesetter() -> CTFramesetter {
    CTFramesetterCreateWithAttributedString(self)
  }

}
