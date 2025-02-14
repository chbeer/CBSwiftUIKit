//
//  FontPicker.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 27.10.24.
//

import os
import SwiftUI

public struct FontPicker: View {
    
    let title: LocalizedStringKey
    @Binding var familyName: String
    
#if os(macOS)
    @State var fontPickerDelegate: FontPickerDelegate?
    @State var font: NSFont
#endif
#if os(iOS)
    @State var font: UIFont
    @State var showFontPicker = false
#endif
    
    public init(_ title: LocalizedStringKey, familyName: Binding<String>) {
        self.title = title
        self._familyName = familyName
        
#if os(macOS)
        self.font = NSFont(name: familyName.wrappedValue, size: 12) ?? NSFont.systemFont(ofSize: 12)
#endif
#if os(iOS)
        self.font = UIFont(name: familyName.wrappedValue, size: 12) ?? UIFont.systemFont(ofSize: 12)
#endif
    }
    
}
