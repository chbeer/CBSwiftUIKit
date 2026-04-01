//
//  EditMode.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 31.03.26.
//

import SwiftUI

#if os(iOS)
public extension Optional where Wrapped == Binding<EditMode> {
    
    var isEditing: Bool {
        self?.wrappedValue.isEditing == true
    }
    
    func toggle() {
        self?.wrappedValue = self?.wrappedValue == .active ? .inactive : .active
    }
    
}
#endif
