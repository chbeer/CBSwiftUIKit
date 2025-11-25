//
//  AttributedColorPicker.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 25.11.25.
//

import SwiftUI

@available(iOS 26.0, macOS 26.0, *)
public struct AttributedColorPicker: View {
    
    @Binding var text: AttributedString
    @Binding var selection: AttributedTextSelection
    
    public init(text: Binding<AttributedString>, selection: Binding<AttributedTextSelection>) {
        self._text = text
        self._selection = selection
    }
    
    public var body: some View {
        ColorPicker(
            "Color",
            selection: Binding(
                get: {
                    selection.typingAttributes(in: text).swiftUI.foregroundColor ?? .primary
                },
                set: { color in
                    text.transformAttributes(in: &selection) {
                        $0.foregroundColor = color
                    }
                }
            )
        )
        .labelsHidden()
    }
}
