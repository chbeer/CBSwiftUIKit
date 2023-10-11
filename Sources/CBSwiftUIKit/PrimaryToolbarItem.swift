//
//  PrimaryToolbarItem.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 11.10.23.
//

import SwiftUI

public struct PrimaryToolbarItem<L: View>: ToolbarContent {
    let action: () -> Void
    @ViewBuilder var label: () -> L
    
    public init(action: @escaping () -> Void, label: @escaping () -> L) {
        self.action = action
        self.label = label
    }

    public var body: some ToolbarContent {
#if canImport(UIKit)
        ToolbarItem(placement: .navigationBarTrailing) {
            button
                .buttonStyle(.borderedProminent)
        }
#else
        ToolbarItem(placement: .primaryAction) {
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
    NavigationStack {
        Text("xxx")
            .toolbar(content: {
                PrimaryToolbarItem {
                } label: {
                    Label("Close", systemImage: "xmark.circle")
                }
            })
    }
}
