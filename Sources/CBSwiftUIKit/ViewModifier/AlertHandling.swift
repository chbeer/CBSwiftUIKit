//
//  AlertHandling.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 22.12.24.
//

import SwiftUI
import Foundation

public struct AlertConfiguration: Equatable, Identifiable {
    
    public struct Action: Equatable, Identifiable {
        public let id = UUID()
        let title: LocalizedStringKey
        let systemImage: String?
        let role: ButtonRole?
        let action: () -> Void
        
        public init(title: LocalizedStringKey, systemImage: String? = nil, role: ButtonRole? = nil, action: @escaping () -> Void) {
            self.title = title
            self.systemImage = systemImage
            self.role = role
            self.action = action
        }
        
        public static func == (lhs: Action, rhs: Action) -> Bool {
            return lhs.id == rhs.id
        }
    }
    
    public let id = UUID()
    let title: LocalizedStringKey
    let message: LocalizedStringKey
    let actions: [Action]
    
    public init(
        title: LocalizedStringKey = "Confirm",
        message: LocalizedStringKey,
        actions: [Action]
    ) {
        self.title = title
        self.message = message
        self.actions = actions
    }
}

open class AlertHandling: NSObject, ObservableObject {
    
    @Published var currentAlert: AlertConfiguration?

    @MainActor
    public func showAlert(_ alert: AlertConfiguration) {
        currentAlert = alert
    }
    
    @MainActor
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
    
    @State var title: LocalizedStringKey = "Confirm"
    @State var alertVisible = false
    
    func body(content: Content) -> some View {
        content
            .onChange(of: alertHandling.currentAlert) { _, newValue in
                title = newValue?.title ?? "Confirm"
                alertVisible = newValue != nil
            }
            .alert(
                title,
                isPresented: $alertVisible,
                presenting: alertHandling) { context in
                    if let alert = context.currentAlert {
                        ForEach(alert.actions) { action in
                            Button(role: action.role) {
                                action.action()
                                alertHandling.currentAlert = nil
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
