//
//  Button.swift
//
//
//  Created by Christian Beer on 03.06.24.
//

import SwiftUI

public extension Button where Label == Image {
    init(systemImage: String, action: @escaping () -> Void) {
        self.init(action: action, label: {
            Image(systemName: systemImage)
        })
    }
}

#Preview {
    Button(systemImage: "play") { }
}
