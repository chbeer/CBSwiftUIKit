//
//  CloseToolbarItem.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 20.08.23.
//

import SwiftUI

struct CloseToolbarItem: ToolbarContent {
    let action: () -> Void
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some ToolbarContent {
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
            Label("Close", systemImage: "xmark.circle")
        }
    }
}

#Preview {
    NavigationStack {
        Text("xxx")
            .toolbar(content: {
                CloseToolbarItem() {}
            })
    }
}
