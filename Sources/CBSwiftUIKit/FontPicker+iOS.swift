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
        Picker(title, selection: $familyName) {
            ForEach(UIFontsManager.shared.familyNames, id: \.self) { family in
                Text(family.nameTranslated).tag(family)
                    .font(Font.custom(family, fixedSize: 16))
            }
        }
    }
    
    // MARK: -
}


#Preview {
    FontPicker(title: "Pick Font", familyName: .constant("Helvetica Neue"))
}

class UIFontsManager {
    static let shared = UIFontsManager()
    
    var familyNames: [String] {
        return ([".AppleSystemUlFont"] + UIFont.familyNames).sorted(using: .localizedStandard)
    }
}

extension String {
    var nameTranslated: String {
        switch self {
        case ".AppleSystemUlFont": return "System Font"
        default: return self
        }
    }
}

#endif
