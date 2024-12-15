//
//  FontPicker.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 27.10.24.
//

import SwiftUI

#if canImport(UIKit)
import UIKit

public extension FontPicker {
    
    var body: some View {
        LabeledContent(title) {
            HStack {
                Text(familyName)
                    .foregroundStyle(.secondary)
                
                Button {
                    showFontPicker = true
                } label: {
                    Image(systemName: "chevron.up.chevron.down")
                }
            }
        }
        .sheet(isPresented: $showFontPicker) {
            FontPickerView(
                font: font,
                familyName: $familyName,
                showFontPicker: $showFontPicker
            )
        }
    }
    
    // MARK: -
}


#Preview {
    FontPicker("Pick Font", familyName: .constant("Helvetica Neue"))
}

class UIFontsManager {
    static let shared = UIFontsManager()
    
    lazy var familyNames: [String] = {
        print("families: \(UIFont.familyNames)")
        return ([".AppleSystemUlFont"] + UIFont.familyNames).sorted(using: .localizedStandard)
    }()
}


struct FontPickerView: UIViewControllerRepresentable {
    
    var font: UIFont
    var familyName: Binding<String>
    var showFontPicker: Binding<Bool>
    
    func makeUIViewController(context: Context) -> UIFontPickerViewController {
        let fontConfig = UIFontPickerViewController.Configuration()
        fontConfig.includeFaces = false
        let fontPicker = UIFontPickerViewController(configuration: fontConfig)
        fontPicker.delegate = context.coordinator
        return fontPicker
    }
    func updateUIViewController(_ fontPicker: UIFontPickerViewController, context: Context) {
        fontPicker.selectedFontDescriptor = font.fontDescriptor
    }
    
    func makeCoordinator() -> FontPickerCoordinator {
        return FontPickerCoordinator(
            font: font,
            familyName: familyName,
            showFontPicker: showFontPicker
        )
    }
    
    class FontPickerCoordinator: NSObject, UIFontPickerViewControllerDelegate {
        
        var font: UIFont
        var familyName: Binding<String>
        var showFontPicker: Binding<Bool>
        
        init(font: UIFont, familyName: Binding<String>, showFontPicker: Binding<Bool>) {
            self.font = font
            self.familyName = familyName
            self.showFontPicker = showFontPicker
        }
        
        func fontPickerViewControllerDidPickFont(_ viewController: UIFontPickerViewController) {
            if let fd = viewController.selectedFontDescriptor {
                self.font = UIFont(descriptor: fd, size: 12)
                self.familyName.wrappedValue = self.font.familyName
                self.showFontPicker.wrappedValue = false
            }
        }
    }
}

#endif

extension String {
    var nameTranslated: String {
        switch self {
        case ".AppleSystemUIFont": return "System Font"
        default: return self
        }
    }
}

