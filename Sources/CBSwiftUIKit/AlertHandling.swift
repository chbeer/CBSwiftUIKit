//
//  AlertHandling.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 22.12.24.
//

import SwiftUI
import Foundation

struct AlertConfiguration: Equatable, Identifiable {
    struct Action: Equatable, Identifiable {
        public let id = UUID()
        let title: LocalizedStringKey
        let systemImage: String?
        let role: ButtonRole?
        let action: () -> Void
        
        init(title: LocalizedStringKey, systemImage: String? = nil, role: ButtonRole? = nil, action: @escaping () -> Void) {
            self.title = title
            self.systemImage = systemImage
            self.role = role
            self.action = action
        }
        
        static func == (lhs: Action, rhs: Action) -> Bool {
            return lhs.id == rhs.id
        }
    }
    
    let id = UUID()
    let message: LocalizedStringKey
    let actions: [Action]
    
    init(message: LocalizedStringKey, actions: [Action]) {
        self.message = message
        self.actions = actions
    }
}

open class AlertHandling: ObservableObject {
    
    @Published var currentAlert: AlertConfiguration?
    
    public init() {}
    
    public func okCancel(message: LocalizedStringKey,
                         okButton: LocalizedStringKey = "OK", ok: @escaping () -> Void,
                         cancel: @escaping() -> Void = {}) {
        currentAlert = .init(message: message, actions: [
            .init(title: okButton, action: {
                ok()
            }),
            .init(title: "Cancel", role: .cancel, action: {
                cancel()
            })
        ])
    }
}

struct AlertHandlingViewModifier: ViewModifier {
    
    @ObservedObject var alertHandling: AlertHandling
    
    @State var alertVisible = false
    
    func body(content: Content) -> some View {
        content
            .onChange(of: alertHandling.currentAlert) { _, newValue in
                alertVisible = newValue != nil
            }
            .alert(
                "Confirm",
                isPresented: $alertVisible,
                presenting: alertHandling) { context in
                    if let alert = context.currentAlert {
                        ForEach(alert.actions) { action in
                            Button(role: action.role) {
                                action.action()
                            } label: {
                                if let systemImage = action.systemImage {
                                    Label(action.title, systemImage: systemImage)
                                } else {
                                    Text(action.title)
                                }
                            }
                        }
                    }
                    
                } message: { context in
                    if let msg = context.currentAlert?.message {
                        Text(msg)
                    }
                }
    }
}

public extension View {
    func withAlertHandling(_ handling: AlertHandling) -> some View {
        modifier(AlertHandlingViewModifier(alertHandling: handling))
            .environmentObject(handling)
    }
}
