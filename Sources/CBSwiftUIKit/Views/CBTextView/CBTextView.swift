//
//  CBTextView.swift
//  MacTesteditor
//
//  Created by Christian Beer on 30.11.25.
//

import SwiftUI

/// Representable for NSTextView and UITextView.
public struct CBTextView: ViewRepresentable {
    
    @Binding var text: NSAttributedString
    @Binding var hasFocus: Bool
    
    internal var onCommit: (() -> Void)? = nil
    
    public init(text: Binding<NSAttributedString>, hasFocus: Binding<Bool>, onCommit: (() -> Void)? = nil) {
        self._text = text
        self._hasFocus = hasFocus
        self.onCommit = onCommit
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public class Coordinator: NSObject {
        var parent: CBTextView
        var isUpdating: Bool = false

        var observer: NSKeyValueObservation?
        
        init(_ parent: CBTextView) {
            self.parent = parent
        }
    }
    
}

#Preview {
    CBTextView(text: .constant(NSAttributedString(string: "Test")), hasFocus: .constant(false))
}
