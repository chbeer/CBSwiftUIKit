//
//  RoundButton.swift
//
//
//  Created by Christian Beer on 02.03.24.
//

import SwiftUI

public struct RoundButton: View {
    let systemImage: String
    let padding: CGFloat
    let prominent: Bool
    let action: () -> Void
    
    public init(systemImage: String, padding: CGFloat = 4, prominent: Bool = false, action: @escaping () -> Void) {
        self.systemImage = systemImage
        self.padding = padding
        self.prominent = prominent
        self.action = action
    }
    
    public var body: some View {
        Button("Close", systemImage: systemImage) {
            action()
        }
        .buttonBorderShape(.circle)
        .if(prominent) { view, prominent in
            if prominent {
                view.buttonStyle(.borderedProminent)
            } else {
                view.buttonStyle(.bordered)
            }
        }
    }
}

#Preview {
    HStack {
        RoundButton(systemImage: "xmark", prominent: false) {}
        RoundButton(systemImage: "xmark", prominent: true) {}
    }
}
