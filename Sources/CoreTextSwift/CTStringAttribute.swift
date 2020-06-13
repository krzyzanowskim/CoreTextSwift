import CoreText

public struct CTStringAttributeName: Hashable, RawRepresentable, CustomStringConvertible {
  public typealias RawValue = String
  public let rawValue: String

  public init?(rawValue: String) {
    self.rawValue = rawValue
  }

  public var description: String {
    rawValue
  }

  @available(OSX, introduced: 10.5, deprecated: 10.11, message: "Use feature type kCharacterShapeType with the appropriate selector")
  public static let characterShape = CTStringAttributeName(rawValue: kCTCharacterShapeAttributeName as String)!
  public static let font = CTStringAttributeName(rawValue: kCTFontAttributeName as String)!
  public static let kern = CTStringAttributeName(rawValue: kCTKernAttributeName as String)!
  public static let ligature = CTStringAttributeName(rawValue: kCTLigatureAttributeName as String)!
  public static let foregroundColor = CTStringAttributeName(rawValue: kCTForegroundColorAttributeName as String)!
  public static let foregroundColorFromContext = CTStringAttributeName(rawValue: kCTForegroundColorFromContextAttributeName as String)!
  public static let paragraphStyle = CTStringAttributeName(rawValue: kCTParagraphStyleAttributeName as String)!
  public static let strokeWidth = CTStringAttributeName(rawValue: kCTStrokeWidthAttributeName as String)!
  public static let strokeColor = CTStringAttributeName(rawValue: kCTStrokeColorAttributeName as String)!
  public static let superscript = CTStringAttributeName(rawValue: kCTSuperscriptAttributeName as String)!
  public static let underlineColor = CTStringAttributeName(rawValue: kCTUnderlineColorAttributeName as String)!
  public static let underlineStyle = CTStringAttributeName(rawValue: kCTUnderlineStyleAttributeName as String)!
  public static let verticalForms = CTStringAttributeName(rawValue: kCTVerticalFormsAttributeName as String)!
  public static let glyphInfo = CTStringAttributeName(rawValue: kCTGlyphInfoAttributeName as String)!
  public static let runDelegate = CTStringAttributeName(rawValue: kCTRunDelegateAttributeName as String)!
  public static let baselineOffset = CTStringAttributeName(rawValue: kCTBaselineOffsetAttributeName as String)!
  public static let trackingAttributeName = CTStringAttributeName(rawValue: kCTTrackingAttributeName as String)!
}

