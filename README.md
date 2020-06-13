# CoreTextSwift

Swifty CoreText API

example:

```swift
let attributedString = NSAttributedString(string: "abcdefgh")
for run in attributedString.line().glyphRuns() {
  let font = run.font
  for glyph in run.glyphs() {
    let glyphPath = font.path(for: glyph)
    // draw path
  }
}
```
