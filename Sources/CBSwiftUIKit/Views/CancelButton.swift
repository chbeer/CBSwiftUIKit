//
//  CancelButton.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 30.10.25.
//

import SwiftUI

public struct CancelButton: View {
    
    let action: () -> Void
    
    @ScaledMetric var circleSize = 30
    @ScaledMetric var shadowRadius = 4
    @ScaledMetric var fontSize = 15
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public var body: some View {
        if #available(iOS 26.0, macOS 26.0, *) {
            Button(role: .cancel) {
                action()
            }
            .accessibilityLabel("Cancel")
        } else {
            Button("Cancel") {
                action()
            }
            .accessibilityLabel("Cancel")
        }
    }
    
}
