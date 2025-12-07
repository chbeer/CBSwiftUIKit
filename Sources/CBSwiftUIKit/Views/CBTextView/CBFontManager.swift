//
//  CBFontManager.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 30.11.25.
//

#if !os(macOS)

import SwiftUI
import UIKit

protocol TagContainer {
    var tag: Int { get }
}

/// Inspired by NSFontManager on AppKit this is supposed to create a bridge
/// between the selected text in UITextView and menu items and buttons showing
/// the state of the selected text.
public class CBFontManager: NSObject {
    
    public struct FontTraitMask: OptionSet {
        
        public static let italic = FontTraitMask(rawValue: 1)
        public static let bold = FontTraitMask(rawValue: 2)
        
        public let rawValue: Int
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }
    
    public static let shared = CBFontManager()
    
    @objc public dynamic private(set) var isBold: Bool = false
    @objc public dynamic private(set) var isItalic: Bool = false
    @objc public dynamic private(set) var isStrikethrough: Bool = false
    @objc public dynamic private(set) var isUnderline: Bool = false
    
    @objc public dynamic private(set) var foregroundColor: UIColor = .label
    
    @objc public dynamic var currentTextView: UITextView?
    
    // MARK: -
    
    public func resetState() {
        isBold = false
        isItalic = false
        isStrikethrough = false
        isUnderline = false
    }
    
    public func state(for trait: FontTraitMask) -> Bool {
        if trait == .bold {
            return isBold
        } else if trait == .italic {
            return isItalic
        }
        return false
    }
    
    public func updateWithAttributes(_ attributes: [NSAttributedString.Key: Any]?) {
        guard let attributes else {
            resetState()
            return
        }
        
        if let font = attributes[.font] as? CBFont {
            let descriptor = font.fontDescriptor
            
            let bold = descriptor.symbolicTraits.contains(.traitBold)
            let italic = descriptor.symbolicTraits.contains(.traitItalic)
            
            if self.isBold != bold {
                self.isBold = bold
            }
            if self.isItalic != italic {
                self.isItalic = italic
            }
//
//            print(">> Updated bold: \(isBold)")
//            print(">> Updated italic: \(italicState)")
        }
        
        let color = attributes[.foregroundColor] as? CBColor ?? .label
        if self.foregroundColor != color {
            self.foregroundColor = color
        }
    }
    
    public func convertFont(_ font: UIFont, toHaveTrait trait: FontTraitMask) -> UIFont {
        var result = font.fontDescriptor.symbolicTraits
        if trait.contains(.italic) {
            result.insert(.traitItalic)
        }
        if trait.contains(.bold) {
            result.insert(.traitBold)
        }
        
        guard let descriptor = font.fontDescriptor.withSymbolicTraits(result) else {
            return font
        }
        return UIFont(descriptor: descriptor, size: font.pointSize)
    }
    public func convertFont(_ font: UIFont, toNotHaveTrait trait: FontTraitMask) -> UIFont {
        var result = font.fontDescriptor.symbolicTraits
        if trait.contains(.italic) {
            result.remove(.traitItalic)
        }
        if trait.contains(.bold) {
            result.remove(.traitBold)
        }
        
        guard let descriptor = font.fontDescriptor.withSymbolicTraits(result) else {
            return font
        }
        return UIFont(descriptor: descriptor, size: font.pointSize)
    }

}

extension CBFontManager.FontTraitMask {
    var symbolicTrait: UIFontDescriptor.SymbolicTraits {
        var result = UIFontDescriptor.SymbolicTraits()
        if self.contains(.italic) {
            result.insert(.traitItalic)
        }
        if self.contains(.bold) {
            result.insert(.traitBold)
        }
        return result
    }
}

// MARK: -

extension UICommand: TagContainer {
    var tag: Int {
        propertyList as? Int ?? 0
    }
}
extension UIView: TagContainer {
}

#endif
