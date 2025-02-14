//
//  FontPicker.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 27.10.24.
//

import SwiftUI

#if canImport(AppKit)

public extension FontPicker {
    
    var body: some View {
        LabeledContent(title) {
            HStack {
                Text(familyName.nameTranslated)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                Button {
                    if NSFontPanel.shared.isVisible {
                        NSFontPanel.shared.orderOut(nil)
                        
                        if NSFontManager.shared.target === self.fontPickerDelegate {
                            return
                        }
                    }
                    
                    self.fontPickerDelegate = FontPickerDelegate(self)
                    NSFontManager.shared.target = self.fontPickerDelegate
                    NSFontPanel.shared.setPanelFont(self.font, isMultiple: false)
                    NSFontPanel.shared.orderBack(nil)
                } label: {
                    Image(systemName: "chevron.up.chevron.down")
                }
            }
        }
    }
    
    func fontSelected() {
        if let name = self.font.familyName {
            self.font = NSFontPanel.shared.convert(self.font)
            self.familyName = name
        }
    }
}

#Preview {
    FontPicker("Pick Font", familyName: .constant("Helvetica Neue"))
}


class FontPickerDelegate {
    var parent: FontPicker

    init(_ parent: FontPicker) {
        self.parent = parent
    }
    
    @objc
    func changeFont(_ id: Any) {
        parent.fontSelected()
    }

}

#endif
