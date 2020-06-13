# CoreTextSwift

Swifty CoreText API

Draw line in currect graphics context

```swift
let attributedString = NSAttributedString(string: "abcdefgh")

guard let ctx = UIGraphicsGetCurrentContext() else {
  return
}

ctx.draw(attributedString.line())
```

Work with glyph run

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
