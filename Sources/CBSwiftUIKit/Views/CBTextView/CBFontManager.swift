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

/// Inspired by NSFontManager on AppKit this is supposed to create a bridge between the selected text in UITextView and menu items and buttons showing the state of the selected text.
/// This is a UIViewController so that it can be put into the responder chain
public class CBFontManager: ObservableObject {
    
    public struct FontTraitMask: OptionSet {
        
        public static let italic = FontTraitMask(rawValue: 1)
        public static let bold = FontTraitMask(rawValue: 2)
        
        public let rawValue: Int
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }
    
    public static let shared = CBFontManager()
    
    @Published public private(set) var boldState: UIMenuElement.State = .off
    @Published public private(set) var italicState: UIMenuElement.State = .off
    @Published public private(set) var strikethroughState: UIMenuElement.State = .off
    @Published public private(set) var underlineState: UIMenuElement.State = .off
    
    @Published public private(set) var foregroundColor: UIColor = .label
    
    public var currentTextView: UITextView?
    
    // MARK: -
    
    public func resetState() {
        boldState = .off
        italicState = .off
        strikethroughState = .off
        underlineState = .off
    }
    
    public func state(for trait: FontTraitMask) -> UIMenuElement.State {
        if trait == .bold {
            return boldState
        } else if trait == .italic {
            return italicState
        }
        return .off
    }
    
    public func updateWithAttributes(_ attributes: [NSAttributedString.Key: Any]?) {
        guard let attributes else {
            resetState()
            return
        }
        
        if let font = attributes[.font] as? UIFont {
            let descriptor = font.fontDescriptor
            
            boldState = descriptor.symbolicTraits.contains(.traitBold) ? .on : .off
            italicState = descriptor.symbolicTraits.contains(.traitItalic) ? .on : .off
//            
//            print(">> Updated bold: \(boldState)")
//            print(">> Updated italic: \(italicState)")
        }
        
        if let color = attributes[.foregroundColor] as? UIColor {
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
