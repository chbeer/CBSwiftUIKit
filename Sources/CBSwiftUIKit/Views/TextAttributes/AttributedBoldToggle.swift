//
//  AttributedBoldToggle.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 25.11.25.
//

import SwiftUI

@available(iOS 26.0, macOS 26.0, *)
public struct AttributedBoldToggle: View {
    
    @Environment(\.fontResolutionContext) private var fontResolutionContext
    
    @Binding var text: AttributedString
    @Binding var selection: AttributedTextSelection
    
    public init(text: Binding<AttributedString>, selection: Binding<AttributedTextSelection>) {
        self._text = text
        self._selection = selection
    }
    
    public var body: some View {
        
        Toggle(
            "Toggle Bold",
            systemImage: "bold",
            isOn: Binding(
                get: {
                    let font = selection.typingAttributes(in: text).font
                    let resolved = (font ?? .default).resolve(
                        in: fontResolutionContext
                    )
                    return resolved.isBold
                },
                set: { isBold in
                    text.transformAttributes(in: &selection) {
                        $0.font = ($0.font ?? .default).bold(isBold)
                    }
                }
            )
        )
        
    }
    
}
