import CoreText
import Foundation

extension CTFramesetter {
  public func createFrame(_ rect: CGRect) -> CTFrame {
    CTFramesetterCreateFrame(self, CFRange(), CGPath(rect: rect, transform: nil), nil)
  }

  public func createFrame(_ path: CGPath) -> CTFrame {
    CTFramesetterCreateFrame(self, CFRange(), path, nil)
  }

  public func frameSize(suggested constraints: CGSize) -> CGSize {
    CTFramesetterSuggestFrameSizeWithConstraints(self, CFRange(), nil, constraints, nil)
  }
}


