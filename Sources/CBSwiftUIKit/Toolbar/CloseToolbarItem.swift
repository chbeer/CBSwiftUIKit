//
//  CloseToolbarItem.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 20.08.23.
//

import SwiftUI

#if os(iOS)

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
    
    var button: some View {
        RoundButton(systemImage: "xmark") {
            action()
        }
        .accessibilityIdentifier("close")
    }
}

#Preview {
    NavigationView {
        Text("xxx")
            .toolbar(content: {
                CloseToolbarItem() {}
            })
    }
}

#endif
