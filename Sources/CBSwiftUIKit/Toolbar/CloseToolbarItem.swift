//
//  CloseToolbarItem.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 20.08.23.
//

import SwiftUI

public struct CloseToolbarItem: ToolbarContent {
    let action: () -> Void
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public var body: some ToolbarContent {
#if canImport(UIKit)
        ToolbarItem(placement: .navigationBarLeading) {
            button
        }
#else
        ToolbarItem(placement: .cancellationAction) {
            button
        }
#endif
    }
    
    @ViewBuilder
    var button: some View {
        if #available(iOS 26.0, macOS 26.0, visionOS 26.0, *) {
            Button(role: .close) {
                action()
            }
            .accessibilityIdentifier("close")
        } else {
            RoundButton(systemImage: "xmark") {
                action()
            }
            .accessibilityIdentifier("close")
        }
    }
}

#Preview {
    NavigationView {
        Text("xxx")
            .toolbar {
                CloseToolbarItem() {}
            }
    }
}
