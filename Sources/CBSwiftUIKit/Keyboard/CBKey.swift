//
//  CBKey.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 14.02.25.
//

/// Represents a key that has been pressed/released.
/// Multi-platform replacement for UIKey
public struct CBKey {
    
    /// String representing what would be inserted into a text field when this key is pressed.
    public let characters: String
    /// String representing what would be inserted into a text field if no modifier key is pressed when this key is presed
    public let charactersIgnoringModifiers: String
    /// Modifier keys pressed alongside this key
    public let modifierFlags: CBModifierFlags
    /// Raw HID code for the pressed key.
    public let keyCode: CBKeyboardHIDUsage?
    
    // MARK: -
    
    /// If a decimal (0..9) key is pressed, the  numeric value is returned
    public var decimal: Int? {
        switch keyCode {
        case .keyboard0, .keypad0: return 0
        case .keyboard1, .keypad1: return 1
        case .keyboard2, .keypad2: return 2
        case .keyboard3, .keypad3: return 3
        case .keyboard4, .keypad4: return 4
        case .keyboard5, .keypad5: return 5
        case .keyboard6, .keypad6: return 6
        case .keyboard7, .keypad7: return 7
        case .keyboard8, .keypad8: return 8
        case .keyboard9, .keypad9: return 9
        default:
            return nil
        }
    }
    
}
