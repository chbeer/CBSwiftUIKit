//
//  View+Conditional.swift
//
//
//  Created by Christian Beer on 20.08.23.
//

import SwiftUI

// Taken from: https://www.avanderlee.com/swiftui/conditional-view-modifier/

public extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: @autoclosure () -> Bool, @ViewBuilder transform: (Self) -> Content) -> some View {
        if condition() {
            transform(self)
        } else {
            self
        }
    }
    
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(
        _ condition: @autoclosure () -> Bool,
        @ViewBuilder then t: (Self) -> Content,
        @ViewBuilder else e: (Self) -> Content
    ) -> some View {
        if condition() {
            t(self)
        } else {
            e(self)
        }
    }
    
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    func `if`<Content: View>(_ condition: @autoclosure () -> Bool, @ViewBuilder transform: (Self, Bool) -> Content) -> some View {
        transform(self, condition())
    }
}
