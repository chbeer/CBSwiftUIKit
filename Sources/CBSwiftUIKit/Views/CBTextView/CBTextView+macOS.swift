//
//  CBTextView.swift
//  MacTesteditor
//
//  Created by Christian Beer on 30.11.25.
//

import SwiftUI

#if os(macOS)

typealias ViewRepresentable = NSViewRepresentable

public extension CBTextView {
    
    func makeNSView(context: Context) -> NSScrollView {
        let scrollView = NSTextView.scrollableTextView()
        let textView = scrollView.documentView as! NSTextView
        
        textView.delegate = context.coordinator
        textView.autoresizingMask = [.width, .height]
        textView.usesFontPanel = true
        textView.isRichText = true
        textView.isSelectable = true
        textView.allowsUndo = true
        
        return scrollView
    }
    
    func updateNSView(_ nsView: NSScrollView, context: Context) {
        guard let textView = nsView.documentView as? NSTextView else { return }
        guard !context.coordinator.isUpdating else { return }
                
        context.coordinator.isUpdating = true
        
        if textView.attributedString() != text {
            textView.textStorage?.setAttributedString(text)
        }
        
        context.coordinator.isUpdating = false
    }
    
}

extension CBTextView.Coordinator: NSTextViewDelegate {
    
    public func textDidChange(_ notification: Notification) {
        guard let textView = notification.object as? NSTextView else { return }
        
        let text = textView.attributedString()
        if text != parent.text {
            parent.text = text
        }
    }

    public func textDidBeginEditing(_ notification: Notification) {
        guard let textView = notification.object as? NSTextView else { return }
        
        parent.hasFocus = true
    }
    
    public func textDidEndEditing(_ notification: Notification) {
        guard let textView = notification.object as? NSTextView else { return }

        let text = textView.attributedString()
        if text != parent.text {
            parent.text = text
        }
        
        parent.onCommit?()
        parent.hasFocus = false
    }
    
}

#endif
