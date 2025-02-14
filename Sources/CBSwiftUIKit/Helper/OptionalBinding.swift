//
//  OptionalBinding.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 21.09.23.
//

import SwiftUI

public func ??(lhs: Binding<Optional<String>>, rhs: String) -> Binding<String> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0.isEmpty ? nil : $0 }
    )
}
public func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}
