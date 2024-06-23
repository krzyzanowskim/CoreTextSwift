import Foundation
import CoreText

public extension NSAttributedString.Key {
    static let runDelegate = NSAttributedString.Key(kCTRunDelegateAttributeName as String)
    static let tracking = NSAttributedString.Key(kCTTrackingAttributeName as String)
    static let foregroundColorFromContext = NSAttributedString.Key(kCTForegroundColorFromContextAttributeName as String)
}
