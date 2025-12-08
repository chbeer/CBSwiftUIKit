//
//  CBFontManager+UI.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 30.11.25.
//

#if !os(macOS)

import Combine
import Foundation
import UIKit
import SwiftUI

public extension CBFontManager {
    
    func formatCommands() -> UIDeferredMenuElement {
        UIDeferredMenuElement.uncached({ provider in
            provider([
                UIKeyCommand(
                    CBFontManager.FontTraitMask.bold.title,
                    image: UIImage(systemName: "bold"),
                    action: #selector(UITextView.toggleTrait(_:)),
                    tag: CBFontManager.FontTraitMask.bold.rawValue,
                    state: CBFontManager.shared.isBold ? .on : .off),
                UIKeyCommand(
                    CBFontManager.FontTraitMask.italic.title,
                    image: UIImage(systemName: "italic"),
                    action: #selector(UITextView.toggleTrait(_:)),
                    tag: CBFontManager.FontTraitMask.italic.rawValue,
                    state: CBFontManager.shared.isItalic ? .on : .off
                )
            ])
        })
    }
    
    func barButtonItem(forTrait trait: CBFontManager.FontTraitMask) -> UIBarButtonItem {
        UIBarButtonItem(customView: TraitButton(trait: trait))
    }
    func barButtonItemForColor(textView: UITextView) -> UIBarButtonItem {
        let well = TextColorWell(frame: .zero)
        well.addTarget(textView, action: #selector(UITextView.updateForegroundColor(_:)), for: .valueChanged)
        return UIBarButtonItem(customView: well)
    }

}

class TraitButton: UIButton {
    
    var observer: NSKeyValueObservation?
    
    init(trait: CBFontManager.FontTraitMask) {
        super.init(frame: .zero)
        configuration = .plain()
        
        setImage(UIImage(systemName: trait.imageName), for: .normal)
        addTarget(nil, action: #selector(UITextView.toggleTrait(_:)), for: .touchUpInside)
        
        tag = trait.rawValue
        
        if trait.contains(.bold) {
            observer = CBFontManager.shared.observe(\.isBold) { [weak self] _, _ in
                self?.isSelected = CBFontManager.shared.isBold
            }
        } else if trait.contains(.italic) {
            observer = CBFontManager.shared.observe(\.isItalic) { [weak self] _, _ in
                self?.isSelected = CBFontManager.shared.isItalic
            }
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class TextColorWell: CBUIColorWell {
    
    var observer: NSKeyValueObservation?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        selectedColor = CBFontManager.shared.foregroundColor
        
        observer = CBFontManager.shared.observe(\.foregroundColor) { [weak self] _, _ in
            self?.selectedColor = CBFontManager.shared.foregroundColor
        }
    }
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CBFontManager.FontTraitMask {
    var title: String {
        if self.contains(.bold) {
            return String(localized: "Bold", bundle: .module)
        }
        if self.contains(.italic) {
            return String(localized: "Italic", bundle: .module)
        }
        return ""
    }
    var imageName: String {
        if self.contains(.bold) {
            return "bold"
        }
        if self.contains(.italic) {
            return "italic"
        }
        return ""
    }
}

#endif
