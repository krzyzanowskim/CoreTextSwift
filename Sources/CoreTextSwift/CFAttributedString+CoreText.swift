import CoreText

public extension CFAttributedString {

  /// Creates a single immutable line object directly from an attributed string.
  func line() -> CTLine {
    CTLineCreateWithAttributedString(self)
  }

  /// Creates an immutable framesetter object from an attributed string.
  func framesetter() -> CTFramesetter {
    CTFramesetterCreateWithAttributedString(self)
  }

}


#if canImport(UIKit)
import UIKit
#endif

#if canImport(AppKit)
import AppKit
#endif

#if canImport(UIKit) || canImport(AppKit)
public extension NSAttributedString {
  func line() -> CTLine {
    (self as CFAttributedString).line()
  }

  func framesetter() -> CTFramesetter {
    (self as CFAttributedString).framesetter()
  }
}
#endif
