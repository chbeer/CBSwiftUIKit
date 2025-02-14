//
//  OnKeyPressViewModifier.swift
//  iVocabulary4
//
//  Created by Christian Beer on 13.02.25.
//

import SwiftUI

#if canImport(UIKit)

import UIKit

struct KeyHandlerView: UIViewRepresentable {
    
    let handler: (CBKey) -> Bool
    
    func makeUIView(context: Context) -> KeyHandlingView {
        return KeyHandlingView(handler: handler)
    }
    func updateUIView(_ uiView: KeyHandlingView, context: Context) {
    }

}

class KeyHandlingView: UIView {

    let handler: (CBKey) -> Bool
    
    override var canBecomeFirstResponder: Bool { return true }
    
    init(handler: @escaping (CBKey) -> Bool) {
        self.handler = handler
        super.init(frame: .zero)
    }
    override init(frame: CGRect) {
        self.handler = { _ in return false }
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        becomeFirstResponder()
    }
    
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        if presses.contains(where: { press in
            // Get the pressed key.
            guard let key = press.key else { return false }
            return handler(CBKey(from: key))
        }) {
            return
        } else {
            super.pressesEnded(presses, with: event)
        }
    }
}

extension CBKey {
    init(from key: UIKey) {
        self.init(
            characters: key.characters,
            charactersIgnoringModifiers: key.charactersIgnoringModifiers,
            modifierFlags: .init(from: key.modifierFlags),
            keyCode: key.keyCode
        )
    }
}

#endif
