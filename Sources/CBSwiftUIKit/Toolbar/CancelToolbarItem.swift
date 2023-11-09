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
    
    var button: some View {
        Button {
            action()
        } label: {
            Text("Cancel")
        }
    }
}

#Preview {
    NavigationView {
        Text("xxx")
            .toolbar(content: {
                CancelToolbarItem() {}
            })
    }
}
