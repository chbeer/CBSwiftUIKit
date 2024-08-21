//
//  File.swift
//
//
//  Created by Christian Beer on 24.07.24.
//

import SwiftUI

public extension View {

    @ViewBuilder
    /// Applies contextual actions to list items: on macOS as contextMeni, on iOS as swipeActions
    /// - Parameter actions: actions to apply
    func contextualActions<MenuItems>(@ViewBuilder actions: @escaping () -> MenuItems) -> some View where MenuItems : View {
#if os(macOS)
        self.contextMenu {
            actions()
        }
#else
        self.swipeActions(edge: .trailing, allowsFullSwipe: false) {
            actions()
        }
#endif
    }
    
}
