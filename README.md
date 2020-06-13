# CoreTextSwift

Swifty CoreText API.

CoreText is C API. This library is a set of wrappers and extensions that makes it convenient to work with Swift.

## Example

Draw line in currect graphics context

```swift
guard let ctx = UIGraphicsGetCurrentContext() else {
  return
}

let attributedString = NSAttributedString(string: "abcdefgh")
ctx.draw(attributedString.line())
```

Use Glyph Run

```swift
let attributedString = NSAttributedString(string: "abcdefgh")

for run in attributedString.line().glyphRuns() {
  let font = run.font
  for glyph in run.glyphs() {
    let glyphPath = font.path(for: glyph)
  }
}
```

Draw Glyph Run to CGContext

```swift
guard let ctx = UIGraphicsGetCurrentContext() else {
  return
}

for run in attributedString.line().glyphRuns() {
  run.draw(in: ctx)
}
```
