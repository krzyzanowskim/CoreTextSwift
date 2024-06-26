import Foundation

extension NSRange {
  init(_ range: CFRange) {
    self = NSMakeRange(range.location == kCFNotFound ? NSNotFound : range.location, range.length)
  }
}

extension CFRange {
  init(_ range: NSRange) {
    self = CFRangeMake(range.location, range.length)
  }
}
