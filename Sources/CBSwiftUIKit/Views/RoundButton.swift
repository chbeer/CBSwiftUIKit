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
        if #available(macOS 14.0, *) {
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
        } else {
            Button {
                action()
            } label: {
                Image(systemName: systemImage)
                    .foregroundColor(.primary)
                    .padding(4)
                    .background {
                        Circle()
                            .fill(.background)
                    }
            }
            .buttonStyle(.borderless)
            .clipShape(Circle())
            .contentShape(Circle())
            .overlay {
                Circle()
                    .stroke(.gray.opacity(0.3))
            }
        }
    }
}

#Preview {
    HStack {
        RoundButton(systemImage: "xmark", prominent: false) {}
        RoundButton(systemImage: "xmark", prominent: true) {}
    }
    .padding()
}

