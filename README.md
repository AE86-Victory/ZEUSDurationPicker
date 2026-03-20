# ZEUSDurationPicker

A customizable duration picker for iOS, built with UIKit and wrapped for SwiftUI.

## Installation

Add as a local Swift Package in Xcode:

```
Packages/ZEUSDurationPicker
```

## Usage

### SwiftUI

```swift
import ZEUSDurationPicker

@State private var duration: TimeInterval = 30 * 60

DurationPickerView(duration: $duration, pickerMode: .hourMinute)
    .textColor(.white)
    .mutedTextColor(.white.withAlphaComponent(0.4))
    .labelFont(UIFont.systemFont(ofSize: 36, weight: .bold))
    .unitLabelFont(UIFont.systemFont(ofSize: 36, weight: .bold))
    .rowHeight(50)
    .columnSpacing(0)
    .labelToUnitSpacing(10)
    .minimumDuration(5 * 60)
    .maximumDuration(10 * 60 * 60)
    .minuteInterval(5)
    .maximumHour(12)
    .hidesSelectionIndicator(true)
```

### UIKit

```swift
import ZEUSDurationPicker

let picker = DurationPicker()
picker.pickerMode = .hourMinute
picker.duration = 30 * 60
picker.textColor = .white
picker.rowHeight = 50
picker.addTarget(self, action: #selector(durationChanged), for: .valueChanged)
```

## API Reference

### Picker Modes

| Mode | Columns |
|------|---------|
| `.hour` | Hour |
| `.hourMinute` | Hour + Minute |
| `.hourMinuteSecond` | Hour + Minute + Second |
| `.minute` | Minute |
| `.minuteSecond` | Minute + Second |
| `.second` | Second |

### SwiftUI Modifiers

| Modifier | Type | Default | Description |
|----------|------|---------|-------------|
| `.textColor(_:)` | `UIColor` | `.label` | Selected row text color |
| `.mutedTextColor(_:)` | `UIColor` | `.tertiaryLabel` | Non-selected row text color |
| `.labelFont(_:)` | `UIFont?` | system | Font for number labels |
| `.unitLabelFont(_:)` | `UIFont?` | system | Font for unit labels (HR, MIN, SEC) |
| `.rowHeight(_:)` | `CGFloat` | `32` | Height of each picker row |
| `.columnSpacing(_:)` | `CGFloat` | `5` | Space between columns |
| `.labelToUnitSpacing(_:)` | `CGFloat` | `6` | Space between number and unit label |
| `.minimumDuration(_:)` | `TimeInterval?` | `nil` | Minimum selectable duration (seconds) |
| `.maximumDuration(_:)` | `TimeInterval?` | `nil` | Maximum selectable duration (seconds) |
| `.hourInterval(_:)` | `Int` | `1` | Hour step interval |
| `.minuteInterval(_:)` | `Int` | `1` | Minute step interval |
| `.secondInterval(_:)` | `Int` | `1` | Second step interval |
| `.maximumHour(_:)` | `Int?` | `nil` | Max hour value (e.g. 12) |
| `.hidesSelectionIndicator(_:)` | `Bool` | `false` | Hide the selection highlight bar |
| `.durationPickerMode(_:)` | `Mode` | `.hourMinuteSecond` | Picker mode |

### UIKit Properties

All modifiers above correspond to `open var` properties on `DurationPicker`:

```swift
open var pickerMode: DurationPicker.Mode
open var duration: TimeInterval
open var minimumDuration: TimeInterval?
open var maximumDuration: TimeInterval?
open var hourInterval: Int
open var minuteInterval: Int
open var secondInterval: Int
open var textColor: UIColor
open var mutedTextColor: UIColor
open var labelFont: UIFont?
open var unitLabelFont: UIFont?
open var columnSpacing: CGFloat
open var labelToUnitSpacing: CGFloat
open var rowHeight: CGFloat
open var maximumHour: Int?
open var hidesSelectionIndicator: Bool
```

Methods:
- `setDuration(_ duration: TimeInterval, animated: Bool)` — set value with optional animation

Events:
- `.valueChanged` — fires when user scrolls to a new value

## License

Internal ZEUS team library.
