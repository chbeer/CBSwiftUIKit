//
//  BottomToolbarItemGroup.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 20.08.23.
//

import SwiftUI

public struct BottomToolbarItemGroup<V: View>: ToolbarContent {
    @ViewBuilder var content: () -> V
    
    public init(@ViewBuilder content: @escaping () -> V) {
        self.content = content
    }
    
    public var body: some ToolbarContent {
#if os(macOS) || os(tvOS)
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
