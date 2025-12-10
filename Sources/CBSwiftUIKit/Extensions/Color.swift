//
//  Color.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 16.11.25.
//

import SwiftUI

#if canImport(UIKit)
import UIKit

public extension Color {
    
    var cbColor: CBColor? {
        UIColor(self)
    }
    
}

#elseif canImport(AppKit)
import AppKit

public extension Color {

    var cbColor: CBColor? {
        NSColor(self)
    }

}

public extension NSColor {

    // MARK: - Label Colors

    static var label: NSColor { .labelColor }
    static var secondaryLabel: NSColor { .secondaryLabelColor }
    static var tertiaryLabel: NSColor { .tertiaryLabelColor }
    static var quaternaryLabel: NSColor { .quaternaryLabelColor }

    // MARK: - Text Colors

    static var placeholderText: NSColor { .placeholderTextColor }

    // MARK: - Background Colors

    static var systemBackground: NSColor { .controlBackgroundColor }
    static var secondarySystemBackground: NSColor { .unemphasizedSelectedContentBackgroundColor }
    static var tertiarySystemBackground: NSColor { .windowBackgroundColor }

    // MARK: - Grouped Background Colors

    static var systemGroupedBackground: NSColor { .windowBackgroundColor }
    static var secondarySystemGroupedBackground: NSColor { .controlBackgroundColor }
    static var tertiarySystemGroupedBackground: NSColor { .unemphasizedSelectedContentBackgroundColor }

    // MARK: - Fill Colors

    static var systemFill: NSColor { .quaternaryLabelColor.withAlphaComponent(0.2) }
    static var secondarySystemFill: NSColor { .quaternaryLabelColor.withAlphaComponent(0.16) }
    static var tertiarySystemFill: NSColor { .quaternaryLabelColor.withAlphaComponent(0.12) }
    static var quaternarySystemFill: NSColor { .quaternaryLabelColor.withAlphaComponent(0.08) }

    // MARK: - Separator Colors

    static var separator: NSColor { .separatorColor }
    static var opaqueSeparator: NSColor { .gridColor }

    // MARK: - Link Color

    static var link: NSColor { .linkColor }

}

#endif

