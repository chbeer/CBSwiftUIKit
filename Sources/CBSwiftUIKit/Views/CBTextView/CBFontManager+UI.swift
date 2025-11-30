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
                    state: CBFontManager.shared.boldState),
                UIKeyCommand(
                    CBFontManager.FontTraitMask.italic.title,
                    image: UIImage(systemName: "italic"),
                    action: #selector(UITextView.toggleTrait(_:)),
                    tag: CBFontManager.FontTraitMask.italic.rawValue,
                    state: CBFontManager.shared.italicState
                )
            ])
        })
    }
    
    @ViewBuilder
    func toggle(for trait: CBFontManager.FontTraitMask) -> some View {
        Toggle(trait.title, isOn: Binding(get: {
            CBFontManager.shared.state(for: trait) == .on
        }, set: { isOn in
            CBFontManager.shared.currentTextView?.updateFont(trait: trait, active: isOn)
        }))
    }
    
    @ViewBuilder
    func foregroundColorPicker() -> some View {
        ColorPicker(selection: Binding(get: {
            Color(CBFontManager.shared.foregroundColor)
        }, set: { color in
            CBFontManager.shared.currentTextView?.setForegroundColor(color.cbColor ?? .label)
        })) {
            EmptyView()
        }
        .labelsHidden()
    }
    
    func barButtonItem(forTrait trait: CBFontManager.FontTraitMask) -> UIBarButtonItem {
        UIBarButtonItem(customView: TraitButton(trait: trait))
    }
    func barButtonItemForColor() -> UIBarButtonItem {
        let well = UIColorWell(frame: .zero)
        
        well.addTarget(nil, action: #selector(UITextView.updateForegroundColor(_:)), for: .valueChanged)
        return UIBarButtonItem(customView: well)
    }

}

class TraitButton: UIButton {
    
    var subscription: AnyCancellable?
    
    init(trait: CBFontManager.FontTraitMask) {
        super.init(frame: .zero)
        configuration = .plain()
        
        setImage(UIImage(systemName: trait.imageName), for: .normal)
        addTarget(nil, action: #selector(UITextView.toggleTrait(_:)), for: .touchUpInside)
        
        tag = trait.rawValue
        
        subscription = CBFontManager.shared
            .objectWillChange
            .sink { [weak self] _ in
                self?.isSelected = CBFontManager.shared.state(for: trait) == .on
        }
    }
    required init?(coder: NSCoder) {
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
