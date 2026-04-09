/// MIT License
///
/// Copyright (c) 2023 Mac Gallagher
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in all
/// copies or substantial portions of the Software.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
/// SOFTWARE.

import SwiftUI

/// A SwiftUI view that wraps the `DurationPicker` UIKit control.
///
/// `DurationPickerView` provides a native SwiftUI interface for inputting time values
/// ranging between 0 and 24 hours. It serves as a SwiftUI wrapper around the UIKit
/// `DurationPicker` control.
///
/// ## Usage
///
/// ```swift
/// struct ContentView: View {
///     @State private var duration: TimeInterval = 3600 // 1 hour
///
///     var body: some View {
///         VStack {
///             DurationPickerView(
///                 duration: $duration,
///                 pickerMode: .hourMinuteSecond
///             )
///
///             Text("Selected: \(Int(duration)) seconds")
///         }
///     }
/// }
/// ```
///
/// ## Configuration
///
/// You can customize the picker by chaining view modifiers:
///
/// ```swift
/// DurationPickerView(duration: $duration)
///     .durationPickerMode(.hourMinute)
///     .minimumDuration(0)
///     .maximumDuration(7200) // 2 hours
///     .minuteInterval(5)
/// ```
///
/// ## Topics
///
/// ### Creating a Duration Picker
/// - ``init(duration:pickerMode:)``
///
/// ### Configuring the Picker
/// - ``durationPickerMode(_:)``
/// - ``minimumDuration(_:)``
/// - ``maximumDuration(_:)``
/// - ``hourInterval(_:)``
/// - ``minuteInterval(_:)``
/// - ``secondInterval(_:)``
@available(iOS 13.0, *)
public struct DurationPickerView: UIViewRepresentable {
    
    /// The binding to the selected duration in seconds.
    @Binding public var duration: TimeInterval
    
    /// The mode of the duration picker.
    public var pickerMode: DurationPicker.Mode
    
    /// The minimum duration that the picker can show (in seconds).
    public var minimumDuration: TimeInterval?
    
    /// The maximum duration that the picker can show (in seconds).
    public var maximumDuration: TimeInterval?
    
    /// The interval at which the duration picker should display hours.
    public var hourInterval: Int
    
    /// The interval at which the duration picker should display minutes.
    public var minuteInterval: Int
    
    /// The interval at which the duration picker should display seconds.
    public var secondInterval: Int
    
    /// The color to use for the text in the duration picker.
    public var textColor: UIColor
    
    /// The color to use for muted text in the duration picker.
    public var mutedTextColor: UIColor

    /// Custom font for the value labels (numbers in the wheel). When nil, uses default.
    public var labelFont: UIFont?

    /// Custom font for the unit labels (e.g. "HR", "MIN"). When nil, uses default.
    public var unitLabelFont: UIFont?

    /// Spacing between columns (e.g. hour and minute). Default 5.
    public var columnSpacing: CGFloat

    /// Spacing between the number and the unit label in each column. Default 6.
    public var labelToUnitSpacing: CGFloat

    /// Height of each row (vertical spacing between rows). Default 32.
    public var rowHeight: CGFloat

    /// When set, the hour column only shows 0...this value (e.g. 12). Nil = 0–23.
    public var maximumHour: Int?

    /// When true, selecting the maximum hour collapses minute/second rows to only `00`.
    public var collapsesSubhourComponentsAtMaximumHour: Bool

    /// Cross-fade duration (seconds) used when minute/second columns collapse/expand at maximum hour.
    public var maximumHourTransitionDuration: TimeInterval

    /// When true, hides the selection indicator (rounded bar behind the selected row).
    public var hidesSelectionIndicator: Bool

    /// Creates a new duration picker view.
    ///
    /// - Parameters:
    ///   - duration: A binding to the selected duration in seconds.
    ///   - pickerMode: The mode of the duration picker. Defaults to `.hourMinuteSecond`.
    public init(
        duration: Binding<TimeInterval>,
        pickerMode: DurationPicker.Mode = .hourMinuteSecond,
        minimumDuration: TimeInterval? = nil,
        maximumDuration: TimeInterval? = nil,
        hourInterval: Int = 1,
        minuteInterval: Int = 1,
        secondInterval: Int = 1,
        textColor: UIColor = .label,
        mutedTextColor: UIColor = .tertiaryLabel,
        labelFont: UIFont? = nil,
        unitLabelFont: UIFont? = nil,
        columnSpacing: CGFloat = 5,
        labelToUnitSpacing: CGFloat = 6,
        rowHeight: CGFloat = 32,
        maximumHour: Int? = nil,
        collapsesSubhourComponentsAtMaximumHour: Bool = true,
        maximumHourTransitionDuration: TimeInterval = 0.18,
        hidesSelectionIndicator: Bool = false
    ) {
        self._duration = duration
        self.pickerMode = pickerMode
        self.minimumDuration = minimumDuration
        self.maximumDuration = maximumDuration
        self.hourInterval = hourInterval
        self.minuteInterval = minuteInterval
        self.secondInterval = secondInterval
        self.textColor = textColor
        self.mutedTextColor = mutedTextColor
        self.labelFont = labelFont
        self.unitLabelFont = unitLabelFont
        self.columnSpacing = columnSpacing
        self.labelToUnitSpacing = labelToUnitSpacing
        self.rowHeight = rowHeight
        self.maximumHour = maximumHour
        self.collapsesSubhourComponentsAtMaximumHour = collapsesSubhourComponentsAtMaximumHour
        self.maximumHourTransitionDuration = max(0, maximumHourTransitionDuration)
        self.hidesSelectionIndicator = hidesSelectionIndicator
    }
    
    public func makeUIView(context: Context) -> DurationPicker {
        let picker = DurationPicker()
        picker.pickerMode = pickerMode
        picker.duration = duration
        
        if let minimumDuration = minimumDuration {
            picker.minimumDuration = minimumDuration
        }
        if let maximumDuration = maximumDuration {
            picker.maximumDuration = maximumDuration
        }
        
        picker.hourInterval = hourInterval
        picker.minuteInterval = minuteInterval
        picker.secondInterval = secondInterval
        picker.textColor = textColor
        picker.mutedTextColor = mutedTextColor
        picker.labelFont = labelFont
        picker.unitLabelFont = unitLabelFont
        picker.columnSpacing = columnSpacing
        picker.labelToUnitSpacing = labelToUnitSpacing
        picker.rowHeight = rowHeight
        picker.maximumHour = maximumHour
        picker.collapsesSubhourComponentsAtMaximumHour = collapsesSubhourComponentsAtMaximumHour
        picker.maximumHourTransitionDuration = maximumHourTransitionDuration
        picker.hidesSelectionIndicator = hidesSelectionIndicator

        // Set up action handler
        picker.addAction(
            UIAction { [weak picker] _ in
                guard let picker = picker else { return }
                DispatchQueue.main.async {
                    duration = picker.duration
                }
            },
            for: .valueChanged
        )
        
        return picker
    }
    
    public func updateUIView(_ picker: DurationPicker, context: Context) {
        // Update picker mode if changed
        if picker.pickerMode != pickerMode {
            picker.pickerMode = pickerMode
        }
        
        // Update duration if changed (with a small tolerance to avoid floating point precision issues)
        if abs(picker.duration - duration) > 0.001 {
            picker.setDuration(duration, animated: false)
        }
        
        // Update minimum duration
        if picker.minimumDuration != minimumDuration {
            picker.minimumDuration = minimumDuration
        }
        
        // Update maximum duration
        if picker.maximumDuration != maximumDuration {
            picker.maximumDuration = maximumDuration
        }
        
        // Update intervals
        if picker.hourInterval != hourInterval {
            picker.hourInterval = hourInterval
        }
        if picker.minuteInterval != minuteInterval {
            picker.minuteInterval = minuteInterval
        }
        if picker.secondInterval != secondInterval {
            picker.secondInterval = secondInterval
        }
        
        // Update colors
        if picker.textColor != textColor {
            picker.textColor = textColor
        }
        if picker.mutedTextColor != mutedTextColor {
            picker.mutedTextColor = mutedTextColor
        }
        if picker.labelFont != labelFont {
            picker.labelFont = labelFont
        }
        if picker.unitLabelFont != unitLabelFont {
            picker.unitLabelFont = unitLabelFont
        }
        if picker.columnSpacing != columnSpacing {
            picker.columnSpacing = columnSpacing
        }
        if picker.labelToUnitSpacing != labelToUnitSpacing {
            picker.labelToUnitSpacing = labelToUnitSpacing
        }
        if picker.rowHeight != rowHeight {
            picker.rowHeight = rowHeight
        }
        if picker.maximumHour != maximumHour {
            picker.maximumHour = maximumHour
        }
        if picker.collapsesSubhourComponentsAtMaximumHour != collapsesSubhourComponentsAtMaximumHour {
            picker.collapsesSubhourComponentsAtMaximumHour = collapsesSubhourComponentsAtMaximumHour
        }
        if abs(picker.maximumHourTransitionDuration - maximumHourTransitionDuration) > 0.0001 {
            picker.maximumHourTransitionDuration = maximumHourTransitionDuration
        }
        if picker.hidesSelectionIndicator != hidesSelectionIndicator {
            picker.hidesSelectionIndicator = hidesSelectionIndicator
        }
    }
}

// MARK: - View Modifiers

@available(iOS 13.0, *)
extension DurationPickerView {
    
    /// Sets the mode of the duration picker.
    ///
    /// - Parameter mode: The picker mode to display.
    /// - Returns: A modified duration picker view.
    public func durationPickerMode(_ mode: DurationPicker.Mode) -> DurationPickerView {
        var view = self
        view.pickerMode = mode
        return view
    }
    
    /// Sets the minimum duration that the picker can show.
    ///
    /// - Parameter duration: The minimum duration in seconds, or `nil` for no minimum.
    /// - Returns: A modified duration picker view.
    public func minimumDuration(_ duration: TimeInterval?) -> DurationPickerView {
        var view = self
        view.minimumDuration = duration
        return view
    }
    
    /// Sets the maximum duration that the picker can show.
    ///
    /// - Parameter duration: The maximum duration in seconds, or `nil` for no maximum.
    /// - Returns: A modified duration picker view.
    public func maximumDuration(_ duration: TimeInterval?) -> DurationPickerView {
        var view = self
        view.maximumDuration = duration
        return view
    }
    
    /// Sets the interval at which the duration picker should display hours.
    ///
    /// - Parameter interval: The hour interval. Must evenly divide into 24.
    /// - Returns: A modified duration picker view.
    public func hourInterval(_ interval: Int) -> DurationPickerView {
        var view = self
        view.hourInterval = interval
        return view
    }
    
    /// Sets the interval at which the duration picker should display minutes.
    ///
    /// - Parameter interval: The minute interval. Must evenly divide into 60.
    /// - Returns: A modified duration picker view.
    public func minuteInterval(_ interval: Int) -> DurationPickerView {
        var view = self
        view.minuteInterval = interval
        return view
    }
    
    /// Sets the interval at which the duration picker should display seconds.
    ///
    /// - Parameter interval: The second interval. Must evenly divide into 60.
    /// - Returns: A modified duration picker view.
    public func secondInterval(_ interval: Int) -> DurationPickerView {
        var view = self
        view.secondInterval = interval
        return view
    }
    
    /// Sets the color to use for the text in the duration picker.
    ///
    /// - Parameter color: The color for the time values and unit labels.
    /// - Returns: A modified duration picker view.
    public func textColor(_ color: UIColor) -> DurationPickerView {
        var view = self
        view.textColor = color
        return view
    }
    
    /// Sets the color to use for muted text in the duration picker.
    ///
    /// - Parameter color: The color for disabled or out-of-range time values.
    /// - Returns: A modified duration picker view.
    public func mutedTextColor(_ color: UIColor) -> DurationPickerView {
        var view = self
        view.mutedTextColor = color
        return view
    }

    /// Sets the font for the value labels (numbers in the wheel).
    public func labelFont(_ font: UIFont?) -> DurationPickerView {
        var view = self
        view.labelFont = font
        return view
    }

    /// Sets the font for the unit labels (e.g. "HR", "MIN").
    public func unitLabelFont(_ font: UIFont?) -> DurationPickerView {
        var view = self
        view.unitLabelFont = font
        return view
    }

    /// Spacing between columns (e.g. hour and minute).
    public func columnSpacing(_ spacing: CGFloat) -> DurationPickerView {
        var view = self
        view.columnSpacing = spacing
        return view
    }

    /// Spacing between the number and the unit label in each column (e.g. between "8" and "HR").
    public func labelToUnitSpacing(_ spacing: CGFloat) -> DurationPickerView {
        var view = self
        view.labelToUnitSpacing = spacing
        return view
    }

    /// Height of each row (vertical spacing between rows, e.g. between "30" and "35").
    public func rowHeight(_ height: CGFloat) -> DurationPickerView {
        var view = self
        view.rowHeight = height
        return view
    }

    /// Limits the hour column to 0...value only (e.g. 12 → wheel shows 0–12, no 13–23).
    public func maximumHour(_ hour: Int?) -> DurationPickerView {
        var view = self
        view.maximumHour = hour
        return view
    }

    /// Whether to collapse minute/second rows to `00` when the selected hour reaches `maximumHour`.
    public func collapsesSubhourComponentsAtMaximumHour(_ enabled: Bool = true) -> DurationPickerView {
        var view = self
        view.collapsesSubhourComponentsAtMaximumHour = enabled
        return view
    }

    /// Sets the cross-fade duration (seconds) for minute/second collapse/expand at maximum hour.
    public func maximumHourTransitionDuration(_ duration: TimeInterval) -> DurationPickerView {
        var view = self
        view.maximumHourTransitionDuration = max(0, duration)
        return view
    }

    /// Hides the default selection indicator (rounded bar behind the selected row).
    public func hidesSelectionIndicator(_ hidden: Bool = true) -> DurationPickerView {
        var view = self
        view.hidesSelectionIndicator = hidden
        return view
    }
}

// MARK: - Preview Support

#if DEBUG
@available(iOS 13.0, *)
struct DurationPickerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Basic example
            StatefulPreviewWrapper(3600) { duration in
                VStack {
                    Text("Duration: \(Int(duration.wrappedValue)) seconds")
                        .padding()
                    DurationPickerView(duration: duration)
                }
            }
            .previewDisplayName("Hour Minute Second")
            
            // Hour minute mode
            StatefulPreviewWrapper(1800) { duration in
                VStack {
                    Text("Duration: \(Int(duration.wrappedValue)) seconds")
                        .padding()
                    DurationPickerView(
                        duration: duration,
                        pickerMode: .hourMinute
                    )
                }
            }
            .previewDisplayName("Hour Minute")
            
            // With constraints
            StatefulPreviewWrapper(900) { duration in
                VStack {
                    Text("Duration: \(Int(duration.wrappedValue)) seconds")
                        .padding()
                    DurationPickerView(duration: duration)
                        .minimumDuration(300)
                        .maximumDuration(3600)
                        .minuteInterval(5)
                }
            }
            .previewDisplayName("With Constraints")
        }
    }
}

@available(iOS 13.0, *)
private struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State var value: Value
    var content: (Binding<Value>) -> Content
    
    init(_ value: Value, content: @escaping (Binding<Value>) -> Content) {
        self._value = State(initialValue: value)
        self.content = content
    }
    
    var body: some View {
        content($value)
    }
}
#endif

