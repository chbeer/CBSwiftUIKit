//
//  File.swift
//
//
//  Created by Christian Beer on 24.07.24.
//
//  Based on FontUtils.swift in LNSwiftUIUtils by Leo Natan on 21/10/2023.
//

import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
#endif

fileprivate extension CBFont {
    
    func with(weight: Weight? = nil, width: Width? = nil, symbolicTraits: CTFontSymbolicTraits = [], feature: [CBFontDescriptor.FeatureKey: Int]? = nil) -> CBFont {
        var mergedsymbolicTraits = CTFontGetSymbolicTraits(self)
        mergedsymbolicTraits.formUnion(symbolicTraits)
        
        let traits = NSMutableDictionary(dictionary: CTFontCopyTraits(self))
        if let weight {
            traits[kCTFontWeightTrait as String] = weight
        }
        if let width {
            traits[kCTFontWidthTrait as String] = width
        }
        traits[kCTFontSymbolicTrait as String] = mergedsymbolicTraits.rawValue
        
        var fontAttributes: [CBFontDescriptor.AttributeName: Any] = [:]
        fontAttributes[.family] = familyName
        fontAttributes[.traits] = traits
        
        if let feature {
            var mergedFeatureSettings = fontAttributes[.featureSettings] as? [[CBFontDescriptor.FeatureKey: Int]] ?? []
            mergedFeatureSettings.append(feature)
            fontAttributes[.featureSettings] = mergedFeatureSettings
        }
        
        #if canImport(UIKit)
        let rv_ = CBFont(descriptor: CBFontDescriptor(fontAttributes: fontAttributes), size: pointSize)
        #else
        let rv_ = CBFont(descriptor: CBFontDescriptor(fontAttributes: fontAttributes), size: pointSize)!
        #endif

        let rv: CBFont
        if symbolicTraits != [] {
            rv = CTFontCreateCopyWithSymbolicTraits(rv_, 0, nil, mergedsymbolicTraits, symbolicTraits) ?? rv_
        } else {
            rv = rv_
        }
        
        //        print("Converted\n\t\(self)\nto\n\t\(rv)\n\n")
        
        return rv
    }
    
    func with(design: CBFontDescriptor.SystemDesign) -> CBFont? {
        guard let designedDescriptor = fontDescriptor.withDesign(design) else { return nil }
        return CBFont(descriptor: designedDescriptor, size: pointSize)
    }
    
    func with(featureType type: Int, selector: Int) -> CBFont? {
#if canImport(UIKit)
        return with(feature: [
            UIFontDescriptor.FeatureKey.featureIdentifier : type as Int,
            UIFontDescriptor.FeatureKey.typeIdentifier : selector as Int
        ])
#else
        return with(feature: [
            NSFontDescriptor.FeatureKey.typeIdentifier : type as Int,
            NSFontDescriptor.FeatureKey.selectorIdentifier : selector as Int
        ])
#endif
    }
    
    var bold: CBFont {
        return with(symbolicTraits: .traitBold)
    }
    
    var italic: CBFont {
        return with(symbolicTraits: .traitItalic)
    }
    
    var monospaced: CBFont {
        let weight: CBFont.Weight
        if let existingWeight = (CTFontCopyTraits(self) as NSDictionary)[kCTFontWeightTrait as String] as? CGFloat {
            weight = CBFont.Weight(rawValue: existingWeight)
        } else {
            weight = .regular
        }
        
        return with(design: .monospaced) ?? CBFont(name: "Menlo", size: pointSize)!.with(weight: weight)
    }
}

public extension CBFontDescriptor.SystemDesign {
    init?(_ design: SwiftUI.Font.Design) {
        switch design {
        case .default:
            self = .default
        case .serif:
            self = .serif
        case .rounded:
            self = .rounded
        case .monospaced:
            self = .monospaced
        @unknown default:
            self = .default
        }
    }
}

public extension CBFont.Weight {
    init?(_ weight: SwiftUI.Font.Weight) {
        guard let rawValue = Mirror(reflecting: weight).descendant("value") as? CGFloat else { return nil }
        self = CBFont.Weight(rawValue)
    }
}

public extension CBFont.TextStyle {
    init(_ textStyle: SwiftUI.Font.TextStyle) {
        switch textStyle {
        case .largeTitle:
#if os(tvOS)
            self = .extraLargeTitle
#else
            self = .largeTitle
#endif
        case .title:
            self = .title1
        case .headline:
            self = .headline
        case .subheadline:
            self = .subheadline
        case .body:
            self = .body
        case .callout:
            self = .callout
        case .footnote:
            self = .footnote
        case .caption:
            self = .caption1
        case .title2:
            self = .title2
        case .title3:
            self = .title3
        case .caption2:
            self = .caption2
        @unknown default:
            self = .body
        }
    }
}

public extension SwiftUI.Font {
    var cbFont: CBFont? {
        guard let base = Mirror(reflecting: self).descendant("provider", "base") else { return nil }
        return SwiftUI.Font.CBFontProvider(from: base)?.cbFont
    }
}

fileprivate extension SwiftUI.Font {
    enum CBFontProvider {
        case system(size: CGFloat, weight: Font.Weight?, design: Font.Design?)
        case textStyle(Font.TextStyle, weight: Font.Weight?, design: Font.Design?)
        case platform(CTFont)
        case named(CBFont)
        
        var cbFont: CBFont? {
            switch self {
            case let .system(size, weight, design):
                let rv: CBFont
                if let weight, let fontWeight = CBFont.Weight(weight) {
                    rv = CBFont.systemFont(ofSize: size, weight: fontWeight)
                } else {
                    rv = CBFont.systemFont(ofSize: size)
                }
                if let design, let systemDesign = CBFontDescriptor.SystemDesign(design), let designedFont = rv.with(design: systemDesign) {
                    return designedFont
                }
                return rv
            case let .textStyle(textStyle, _, _):
                return CBFont.preferredFont(forTextStyle: CBFont.TextStyle(textStyle))
            case let .platform(font):
                return font as CBFont
            case let .named(font):
                return font
            }
        }
        
        init?(from reflection: Any) {
            let desc = String(describing: type(of: reflection))
            let mirror = Mirror(reflecting: reflection)
            
            if let regex = try? NSRegularExpression(pattern: "ModifierProvider<(.*)>"), let match = regex.firstMatch(in: desc, range: NSRange(desc.startIndex..<desc.endIndex, in: desc)) {
                let modifier = desc[Range(match.range(at: 1), in: desc)!]
                
                guard let sFont = mirror.descendant("base") as? Font, var font = sFont.cbFont else { return nil }
                
                //                print(modifier)
                
                switch modifier {
                case "BoldModifier":
                    font = font.bold
                    break
                case "ItalicModifier":
                    font = font.italic
                    break
                case "MonospacedModifier":
                    font = font.monospaced
                    break
                case "MonospacedDigitModifier":
                    font = font.with(featureType: kNumberSpacingType, selector: kMonospacedNumbersSelector) ?? font
                    break
                case "WeightModifier":
                    if let weight = mirror.descendant("modifier", "weight", "value") as? CGFloat {
                        font = font.with(weight: CBFont.Weight(rawValue: weight))
                    }
                    break
                case "WidthModifier":
                    if let width = mirror.descendant("modifier", "width") as? CGFloat {
                        font = font.with(width: CBFont.Width(rawValue: width))
                    }
                    break
                case "LeadingModifier":
                    //Unsupported
                    break
                case "FeatureSettingModifier":
                    if let type = mirror.descendant("modifier", "type")as? Int, let selector = mirror.descendant("modifier", "selector") as? Int {
                        font = font.with(featureType: type, selector: selector) ?? font
                    }
                    break
                default:
                    break
                }
                
                self = .named(font)
                return
            }
            
            switch desc {
            case "SystemProvider":
                var props: (size: CGFloat?, weight: Font.Weight?, design: Font.Design?) = (nil, nil, nil)
                
                props.size = mirror.descendant("size") as? CGFloat
                props.weight = mirror.descendant("weight") as? Font.Weight
                props.design = mirror.descendant("design") as? Font.Design
                
                guard let size = props.size else { return nil }
                
                self = .system( size: size, weight: props.weight, design: props.design)
            case "TextStyleProvider":
                var props: (style: Font.TextStyle?, weight: Font.Weight?, design: Font.Design?) = (nil, nil, nil)
                
                props.style = mirror.descendant("style") as? Font.TextStyle
                props.weight = mirror.descendant("weight") as? Font.Weight
                props.design = mirror.descendant("design") as? Font.Design
                
                guard let style = props.style else { return nil }
                
                self = .textStyle(style, weight: props.weight, design: props.design)
            case "PlatformFontProvider":
                guard let font = mirror.descendant("font") as? CBFont else { return nil }
                self = .platform(font)
            case "NamedProvider":
                guard let name = mirror.descendant("name") as? String, let size = mirror.descendant("size") as? CGFloat else { return nil }
                
                let font = CBFont(name: name, size: size)
                guard var font else { return nil }
                
                #if canImport(UIKit)
                if let textStyle = mirror.descendant("textStyle") as? SwiftUI.Font.TextStyle {
                    font = UIFontMetrics(forTextStyle: CBFont.TextStyle(textStyle)).scaledFont(for: font)
                }
                #endif
                
                self = .named(font)
                
            default:
                return nil
            }
        }
    }
}
