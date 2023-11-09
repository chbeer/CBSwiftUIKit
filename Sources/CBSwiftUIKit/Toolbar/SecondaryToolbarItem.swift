//
//  SecondaryToolbarItem.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 11.10.23.
//

import SwiftUI

public struct SecondaryToolbarItem<L: View>: ToolbarContent {
    let action: () -> Void
    @ViewBuilder var label: () -> L
    
    public init(action: @escaping () -> Void, label: @escaping () -> L) {
        self.action = action
        self.label = label
    }

    public var body: some ToolbarContent {
#if canImport(UIKit)
        ToolbarItem(placement: .navigationBarLeading) {
            button
        }
#else
        ToolbarItem(placement: .secondaryAction) {
            button
        }
#endif
    }
    
    var button: some View {
        Button {
            action()
        } label: {
            label()
        }
    }
}

#Preview {
    NavigationView {
        Text("xxx")
            .toolbar(content: {
                SecondaryToolbarItem {
                } label: {
                    Label("Close", systemImage: "xmark.circle")
                }
            })
    }
}
