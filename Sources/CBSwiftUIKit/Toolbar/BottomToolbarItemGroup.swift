//
//  BottomToolbarItemGroup.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 20.08.23.
//

import SwiftUI

public struct BottomToolbarItemGroup<V: View>: ToolbarContent {
    @ViewBuilder var content: () -> V
    public var body: some ToolbarContent {
#if canImport(AppKit)
        ToolbarItemGroup(placement: .primaryAction) {
            content()
        }
#else
        ToolbarItemGroup(placement: .bottomBar) {
            content()
        }
#endif
    }
}

#Preview {
    NavigationView {
        Text("xx")
            .toolbar {
                BottomToolbarItemGroup() {
                    Text("x")
                }
            }
    }
}
