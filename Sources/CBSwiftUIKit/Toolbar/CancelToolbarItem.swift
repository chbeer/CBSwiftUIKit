//
//  CancelToolbarItem.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 20.08.23.
//

import SwiftUI

public struct CancelToolbarItem: ToolbarContent {
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
            Button(role: .cancel) {
                action()
            }
            .accessibilityIdentifier("cancel")
        } else {
            Button {
                action()
            } label: {
                Text("Cancel")
            }
            .accessibilityIdentifier("cancel")
        }
    }
}

#Preview {
    NavigationView {
        Text("xxx")
            .toolbar {
                CancelToolbarItem() {}
            }
    }
}
