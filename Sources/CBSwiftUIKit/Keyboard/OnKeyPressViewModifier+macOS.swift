//
//  OnKeyPressViewModifier.swift
//  iVocabulary4
//
//  Created by Christian Beer on 13.02.25.
//

import SwiftUI

#if os(macOS)
import AppKit

struct KeyHandlerView: NSViewRepresentable {
    
    let handler: (CBKey) -> Bool
    
    func makeNSView(context: Context) -> KeyHandlingView {
        return KeyHandlingView(handler: handler)
    }
    func updateNSView(_ nsView: NSViewType, context: Context) {
    }
    
}
class KeyHandlingView: NSView {
    
    let handler: (CBKey) -> Bool
    
    var monitor: Any? = nil
    
    init(handler: @escaping (CBKey) -> Bool) {
        self.handler = handler
        super.init(frame: .zero)
    }
    override init(frame frameRect: NSRect) {
        self.handler = { _ in return true }
        super.init(frame: frameRect)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
     
        if superview == nil {
            if let monitor {
                NSEvent.removeMonitor(monitor)
            }
        } else {
            monitor = NSEvent.addLocalMonitorForEvents(matching: .keyUp) { [weak self] event in
                if self?.handler(CBKey(from: event)) == true {
                    return nil
                } else {
                    return event
                }
            }
        }
    }
}

extension CBKey {
    
    init(from event: NSEvent) {
        self.init(
            characters: event.characters ?? "",
            charactersIgnoringModifiers: event.charactersIgnoringModifiers ?? "",
            modifierFlags: .init(from: event.modifierFlags),
            keyCode: CBKeyboardHIDUsage(keyCode: event.keyCode))
    }
    
}

#endif
