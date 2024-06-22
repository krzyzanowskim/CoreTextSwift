import CoreText
import Foundation

extension CTFramesetter {
  
  /// Creates an immutable frame using a framesetter.
  /// - Parameter rect: Rect of the frame
  /// - Parameter range: The range, of the attributed string that was used to create the framesetter, that is to be typeset in lines fitted into the frame.
  /// - Returns: A reference to a new CTFrame object.
  public func createFrame(_ rect: CGRect, stringRange: NSRange = NSRange()) -> CTFrame {
    CTFramesetterCreateFrame(self, CFRange(stringRange), CGPath(rect: rect, transform: nil), nil)
  }

  public func createFrame(_ path: CGPath, stringRange: NSRange = NSRange()) -> CTFrame {
    CTFramesetterCreateFrame(self, CFRange(stringRange), path, nil)
  }

  public func frameSize(suggested constraints: CGSize, stringRange: NSRange = NSRange()) -> CGSize {
    CTFramesetterSuggestFrameSizeWithConstraints(self, CFRange(stringRange), nil, constraints, nil)
  }

}


