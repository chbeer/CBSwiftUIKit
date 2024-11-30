//
//  SelectAllTextOnBeginEditingModifier.swift
//
//  Created by Christian Beer on 28.11.24.
//

import SwiftUI
import Combine

#if canImport(UIKit)
import UIKit

public struct SelectAllTextOnBeginEditingModifier: ViewModifier {
    @ViewBuilder @MainActor
    public func body(content: Content) -> some View {
        content
            .onReceive(NotificationCenter.default.publisher(
                for: UITextField.textDidBeginEditingNotification)) { _ in
                    DispatchQueue.main.async {
                        UIApplication.shared.sendAction(
                            #selector(UIResponder.selectAll(_:)), to: nil, from: nil, for: nil
                        )
                    }
                }
        }
}

extension View {
    public func selectAllTextOnBeginEditing() -> some View {
        modifier(SelectAllTextOnBeginEditingModifier())
    }
}

#else

extension View {
    public func selectAllTextOnBeginEditing() -> some View {
        self
    }
}

#endif
