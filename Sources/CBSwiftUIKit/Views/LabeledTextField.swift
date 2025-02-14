//
//  LabeledTextField.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 07.04.23.
//

import SwiftUI

enum TitleType {
    case `static`(String)
    case localized(LocalizedStringKey)
}

public struct LabeledTextField: View {
    
    let title: TitleType
    @Binding var text: String
    
    public init(_ title: LocalizedStringKey, text: Binding<String>) {
        self.title = .localized(title)
        self._text = text
    }
//    @_disfavoredOverload
//    public init(_ title: String, text: Binding<String>) {
//        self.title = .static(title)
//        self._text = text
//    }

    public var body: some View {
#if canImport(AppKit)
        switch title {
        case .static(let title):
            TextField(title, text: $text)
                .foregroundColor(.secondary)
        case .localized(let titleKey):
            TextField(titleKey, text: $text)
                .foregroundColor(.secondary)
        }
#else
        switch title {
        case .static(let title):
            LabeledContent(title) {
                TextField(title, text: $text)
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(.secondary)
            }
        case .localized(let titleKey):
            LabeledContent(titleKey) {
                TextField(titleKey, text: $text)
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(.secondary)
            }
        }
#endif
    }
}

struct LabeledTextField_Previews: PreviewProvider {
    static var previews: some View {
        LabeledTextField("Test", text: .constant("a"))
    }
}
