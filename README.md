# AMPopover

A simple and customizable iOS popover component with automatic position adjustment and arrow pointing.

[English](./README.md) | [简体中文](./README_CN.md)

## Features

- Automatic position adjustment to ensure popover always stays within screen bounds
- Smart arrow pointing with automatic direction selection
- Customizable background color, corner radius, arrow size, and more
- Background tap to dismiss
- Smooth animation effects
- Support for both Swift Package Manager and CocoaPods

## Smart Position Adjustment

AMPopover intelligently calculates the optimal display position based on the anchor view:

1. Preferentially displays below the anchor view
2. Automatically switches to above if there's insufficient space below
3. Adjusts horizontal position to prevent screen edge overflow
4. Maintains minimum margins for optimal visual experience

## Installation

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/owlivendy/AMPopover.git", from: "1.0.0")
]
```

### CocoaPods

Add the following to your `Podfile`:

```ruby
pod 'AMPopover'
```

Then run:

```bash
pod install
```

## Usage

### Basic Usage

```swift
import AMPopover

// Create content view
let contentView = UIView()
contentView.frame = CGRect(x: 0, y: 0, width: 200, height: 100)

// Create popover
let popover = AMPopover(contentView: contentView)

// Show popover
popover.show(with: anchorView)
```

### Customization

```swift
let popover = AMPopover(contentView: contentView)

// Customize appearance
popover.arrowHeight = 10
popover.arrowWidth = 16
popover.cornerRadius = 12
popover.minMargin = 15
popover.contentBackgroundColor = .systemGray6

// Show popover
popover.show(with: anchorView)
```

### Menu Example

```swift
// Create menu items
let items = [
    AMPopoverMenuItem.item(with: "Share"),
    AMPopoverMenuItem.item(with: "Edit"),
    AMPopoverMenuItem.item(with: "Delete")
]

// Create menu view
let menuView = AMPopoverMenuView(menuItems: items)

// Customize menu style
menuView.menuWidth = 120
menuView.rowHeight = 44
menuView.maxHeight = 44 * 4
menuView.menuBackgroundColor = .systemGray6

// Set selection callback
menuView.didSelectBlock = { item in
    print("Selected: \(item.title)")
}

// Show menu
menuView.show(with: button)
```

## Requirements

- iOS 12.0+
- Swift 5.0+

## License

AMPopover is available under the MIT license. See the [LICENSE](LICENSE) file for more info. 