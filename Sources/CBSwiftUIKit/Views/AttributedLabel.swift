//
//  AttributedLabel.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 31.03.26.
//

import SwiftUI

public struct AttributedLabel {
    let attributedText: NSAttributedString
    
    public init(attributedText: NSAttributedString) {
        self.attributedText = attributedText
    }
}

#if canImport(UIKit)
import UIKit

extension AttributedLabel: UIViewRepresentable {
    public func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontForContentSizeCategory = true
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }
    public func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.attributedText = attributedText
        uiView.preferredMaxLayoutWidth = uiView.bounds.width
    }
    public func sizeThatFits(_ proposal: ProposedViewSize, uiView: UILabel, context: Context) -> CGSize? {
        // Enable line wrapping by passing proposed width to the label
        if let width = proposal.width, width.isFinite, width > 0 {
            uiView.preferredMaxLayoutWidth = width
            let size = uiView.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude))
            return size
        }
        return nil
    }
}

#else
import AppKit
extension AttributedLabel: NSViewRepresentable {
    public func makeNSView(context: Context) -> NSTextField {
        let label = NSTextField(labelWithString: "")
        label.isBordered = false
        label.isEditable = false
        label.isSelectable = false
        label.drawsBackground = false
        label.lineBreakMode = .byWordWrapping
        label.maximumNumberOfLines = 0
        label.usesSingleLineMode = false
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }
    public func updateNSView(_ nsView: NSTextField, context: Context) {
        nsView.attributedStringValue = attributedText
    }
}

#endif
