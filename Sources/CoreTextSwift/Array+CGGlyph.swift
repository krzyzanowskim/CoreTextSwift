import CoreText

extension Array where Element == CGGlyph {
  func advances(for font: CTFont, orientation: CTFontOrientation = .default) -> [CGSize] {
    [CGSize](unsafeUninitializedCapacity: count) { (bufferPointer, count) in
      CTFontGetAdvancesForGlyphs(font, orientation, self, bufferPointer.baseAddress!, self.count)
      count = self.count
    }
  }

  func boundingRects(for font: CTFont, orientation: CTFontOrientation = .default) -> [CGRect] {
    [CGRect](unsafeUninitializedCapacity: count) { (bufferPointer, count) in
      CTFontGetBoundingRectsForGlyphs(font, orientation, self, bufferPointer.baseAddress!, self.count)
      count = self.count
    }
  }

  func opticalBounds(for font: CTFont) -> [CGRect] {
    [CGRect](unsafeUninitializedCapacity: count) { (bufferPointer, count) in
      CTFontGetOpticalBoundsForGlyphs(font, self, bufferPointer.baseAddress!, self.count, CFOptionFlags())
      count = self.count
    }
  }
}
