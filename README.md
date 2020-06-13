# CoreTextSwift

Swifty CoreText API

draw line in currect graphics context

```swift
let attributedString = NSAttributedString(string: "abcdefgh")
UIGraphicsGetCurrentContext()?.draw(attributedString.line())
```



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
