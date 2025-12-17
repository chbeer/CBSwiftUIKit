//
//  CBTextView.swift
//  MacTesteditor
//
//  Created by Christian Beer on 30.11.25.
//

import os
import SwiftUI

#if !os(macOS)

public typealias ViewRepresentable = UIViewRepresentable

public extension CBTextView {
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.isScrollEnabled = true
        textView.isEditable = true
        textView.isSelectable = true
        //textView.allowsEditingTextAttributes = true // This provides all attributes what we don't want
        textView.dataDetectorTypes = []
        if #available(iOS 18.0, *) {
            textView.allowedWritingToolsResultOptions = []
        }
        textView.autocorrectionType = .no
        textView.autocapitalizationType = .none
        
        let toolbar = UIToolbar()
        toolbar.items = [
            CBFontManager.shared.barButtonItem(forTrait: .bold),
            CBFontManager.shared.barButtonItem(forTrait: .italic),
            CBFontManager.shared.barButtonItemForColor(textView: textView)
        ]
        toolbar.sizeToFit()
        
        textView.inputAccessoryView = toolbar
        
        context.coordinator.observer = textView.observe(\.selectedTextRange) { _, _ in
            context.coordinator.textViewDidChangeSelection(textView)
        }
        
        return textView
    }
    
    func updateUIView(_ textView: UITextView, context: Context) {
        guard !context.coordinator.isUpdating else { return }
        context.coordinator.isUpdating = true
        
        if textView.attributedText != text {
            os_log("updateUIView: \(text)")
            
            textView.attributedText = text
        }
        
        context.coordinator.isUpdating = false
    }
    
}

extension CBTextView.Coordinator: UITextViewDelegate {
    
    public func textViewDidChange(_ textView: UITextView) {
        guard !isUpdating else { return }
        
        let text = textView.attributedText
        if parent.text != text {
            parent.text = text ?? NSAttributedString()
        }
        
        os_log("textViewDidChange: \(text)")
    }
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        CBFontManager.shared.currentTextView = textView
        
        parent.hasFocus = true
    }
    public func textViewDidEndEditing(_ textView: UITextView) {
        let text = textView.attributedText
        
        os_log("textViewDidEnd: \(text)")
        
        if parent.text != text {
            parent.text = text ?? NSAttributedString()
        }
        parent.onCommit?()
        
        parent.hasFocus = false

        if CBFontManager.shared.currentTextView == textView {
            CBFontManager.shared.currentTextView = nil
        }
    }
    
    public func textViewDidChangeSelection(_ textView: UITextView) {
        guard let text = textView.attributedText,
              let range = textView.selectedTextRange else {
            CBFontManager.shared.updateWithAttributes(textView.typingAttributes)
            return
        }
        
        let beginning = textView.beginningOfDocument
        let location = textView.offset(from: beginning, to: range.start)
            
        if location < text.length {
            let attributes = text.attributes(at: location, effectiveRange: nil)
            CBFontManager.shared.updateWithAttributes(attributes)
        } else {
            CBFontManager.shared.updateWithAttributes(textView.typingAttributes)
        }
    }
    
}

extension UITextView {
    
    @IBAction public func addTrait(_ sender: Any?) {
        guard isFirstResponder, let trait = traitFrom(sender) else { return }
        updateFont(trait: trait, active: true)
    }
    @IBAction public func removeTrait(_ sender: Any?) {
        guard isFirstResponder, let trait = traitFrom(sender) else { return }
        updateFont(trait: trait, active: false)
    }
    @IBAction public func toggleTrait(_ sender: Any?) {
        guard isFirstResponder, let trait = traitFrom(sender) else { return }
        if CBFontManager.shared.state(for: trait) {
            updateFont(trait: trait, active: false)
        } else {
            updateFont(trait: trait, active: true)
        }
    }
    
    @IBAction public func updateForegroundColor(_ sender: Any?) {
        guard isFirstResponder, let well = sender as? CBUIColorWell, let color = well.selectedColor else { return }
        setForegroundColor(color)
    }
    
    // MARK: -
    
    func traitFrom(_ sender: Any?) -> CBFontManager.FontTraitMask? {
        guard let container = sender as? TagContainer else { return nil }
        return .init(rawValue: container.tag)
    }
    
    func updateFont(trait: CBFontManager.FontTraitMask, active: Bool) {
        guard let text = attributedText else { return }
        
        let selectedRange = selectedRange
        let attributedText = NSMutableAttributedString(attributedString: attributedText)
        
        let convert = { (font: UIFont) in
            if active {
                return CBFontManager.shared.convertFont(font, toHaveTrait: trait)
            } else {
                return CBFontManager.shared.convertFont(font, toNotHaveTrait: trait)
            }
        }
        
        if selectedRange.length == 0 {
            // Update typing attributes for new text
            if let font = typingAttributes[.font] as? UIFont {
                let newFont = convert(font)
                typingAttributes[.font] = newFont
            }
            return
        }
        
        var attributes = text.attributes(at: selectedRange.location, effectiveRange: nil)
        let font = (attributes[.font] ?? typingAttributes[.font]) as? UIFont ?? UIFont.systemFont(ofSize: 12)
        
        let newFont = convert(font)
        
        // Apply font to selected range
        attributedText.addAttribute(.font, value: newFont, range: selectedRange)
        
        self.attributedText = attributedText
        self.selectedRange = selectedRange  // restore selection
        
        self.delegate?.textViewDidChange?(self)
        
        attributes[.font] = newFont
        CBFontManager.shared.updateWithAttributes(attributes)
    }
    
    func setForegroundColor(_ color: UIColor) {
        guard let text = attributedText else { return }
        
        let selectedRange = selectedRange
        let attributedText = NSMutableAttributedString(attributedString: attributedText)
        
        if selectedRange.length == 0 {
            // Update typing attributes for new text
            typingAttributes[.foregroundColor] = color
            return
        }
        
        var attributes = text.attributes(at: selectedRange.location, effectiveRange: nil)
               
        // Apply font to selected range
        attributedText.addAttribute(.foregroundColor, value: color, range: selectedRange)
        
        self.attributedText = attributedText
        self.selectedRange = selectedRange  // restore selection
        
        self.delegate?.textViewDidChange?(self)
        
        attributes[.foregroundColor] = color
        CBFontManager.shared.updateWithAttributes(attributes)
    }
}

#endif
