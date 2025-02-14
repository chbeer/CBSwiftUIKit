//
//  OnKeyPressViewModifier.swift
//  iVocabulary4
//
//  Created by Christian Beer on 13.02.25.
//

import SwiftUI

public struct OnKeyPressViewModifier: ViewModifier {
    
    let handler: (CBKey) -> Bool
    
    @ViewBuilder @MainActor
    public func body(content: Content) -> some View {
        content
            .background {
                KeyHandlerView(handler: handler)
            }
    }
    
}

public extension View {
    /// Handles global key presses
    func onGlobalKeyPressed(_ handler: @escaping (CBKey) -> Bool) -> some View {
        modifier(OnKeyPressViewModifier(handler: handler))
    }
}
