//
//  ButtonToolbarItem.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 15.11.25.
//

import SwiftUI

public struct ButtonToolbarItem: ToolbarContent {
    
    public enum Role {
        case destructive(LocalizedStringKey)
        case cancel
        case confirm
        case close
    }
    
    let role: Role
    let action: () -> Void
    
    public init(role: Role, action: @escaping () -> Void) {
        self.role = role
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
    
    @ViewBuilder
    var button: some View {
        if #available(iOS 26.0, macOS 26.0, visionOS 26.0, *) {
            if case .destructive(let title) = role {
                Button(role: role.buttonRole) {
                    action()
                } label: {
                    Text(title)
                }
                .accessibilityIdentifier(role.accessibiltyIdentifier)
            } else {
                Button(role: role.buttonRole) {
                    action()
                }
                .accessibilityIdentifier(role.accessibiltyIdentifier)
            }
        } else {
            Button(role.title) {
                action()
            }
            .accessibilityIdentifier(role.accessibiltyIdentifier)
        }
    }
}

//#Preview {
//    ButtonToolbarItem(role: .cancel) {
//        
//    }
//}

extension ButtonToolbarItem.Role {
    var buttonRole: ButtonRole {
        switch self {
        case .destructive:
            return .destructive
        case .cancel:
            return .cancel
        case .confirm:
            if #available(iOS 26.0, macOS 26.0, visionOS 26.0, *) {
                return .confirm
            } else {
                return .cancel
            }
        case .close:
            if #available(iOS 26.0, macOS 26.0, visionOS 26.0, *) {
                return .close
            } else {
                return .cancel
            }
        }
    }
    
    var accessibiltyIdentifier: String {
        switch self {
        case .destructive: return "destructive"
        case .cancel: return "cancel"
        case .confirm: return "confirm"
        case .close: return "close"
        }
    }
    
    var title: LocalizedStringKey {
        switch self {
        case .destructive(let title): return title
        case .cancel: return "Cancel"
        case .confirm: return "Confirm"
        case .close: return "Close"
        }
    }
}
