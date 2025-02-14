//
//  ModifierFlags.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 14.02.25.
//

#if canImport(UIKit)
import UIKit
#endif
#if canImport(AppKit)
import AppKit
#endif

public struct CBModifierFlags: OptionSet {
    
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static let shift    = CBModifierFlags(rawValue: 1 << 17)
    public static let control  = CBModifierFlags(rawValue: 1 << 18)
    public static let option   = CBModifierFlags(rawValue: 1 << 19)
    public static let command  = CBModifierFlags(rawValue: 1 << 20)
    
}
    
extension CBModifierFlags: CustomDebugStringConvertible {

#if canImport(UIKit)

    init(from flags: UIKeyModifierFlags) {
        self.init(rawValue: flags.rawValue)
    }

#endif
#if canImport(AppKit)

    init(from flags: NSEvent.ModifierFlags) {
        self.init(rawValue: Int(flags.rawValue))
    }

#endif
    
    public var debugDescription: String {
        var result: [String] = []
        if self.contains(.shift) {
            result.append("shift")
        }
        if self.contains(.control) {
            result.append("control")
        }
        if self.contains(.option) {
            result.append("option")
        }
        if self.contains(.command) {
            result.append("command")
        }
        return result.joined(separator: ", ")
    }
    
}
