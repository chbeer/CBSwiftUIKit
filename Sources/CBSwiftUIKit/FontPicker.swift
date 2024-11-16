//
//  FontPicker.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 27.10.24.
//

import SwiftUI

public struct FontPicker: View {
    
    let title: LocalizedStringKey
    @Binding var familyName: String
    
#if os(macOS)
    @State var fontPickerDelegate: FontPickerDelegate?
    @State var font: NSFont
#endif
    
    public init(title: LocalizedStringKey, familyName: Binding<String>) {
        self.title = title
        self._familyName = familyName
#if os(macOS)
        self.font = NSFont(name: familyName.wrappedValue, size: 12) ?? NSFont.systemFont(ofSize: 12)
#endif
    }
    
}
