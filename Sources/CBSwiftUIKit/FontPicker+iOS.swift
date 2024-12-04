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
    FontPicker("Pick Font", familyName: .constant("Helvetica Neue"))
}

class UIFontsManager {
    static let shared = UIFontsManager()
    
    var familyNames: [String] {
        return ([".AppleSystemUlFont"] + UIFont.familyNames).sorted(using: .localizedStandard)
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
