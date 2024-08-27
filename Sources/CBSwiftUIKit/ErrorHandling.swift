//
//  ErrorHandling.swift
//
//  Created by Christian Beer on 04.04.23.
//

import SwiftUI

public struct ErrorAlert: Identifiable {
    public var id = UUID()
    public var message: String
    public var dismissAction: (() -> Void)?
}

open class ErrorHandling: ObservableObject {
    @Published var currentAlert: ErrorAlert?

    public init() {}
    
    @MainActor
    open func handle(error: Error) {
        print("🔥 error: \(error)")
        currentAlert = ErrorAlert(message: error.localizedDescription)
    }
    
    @MainActor
    @discardableResult
    public func perform(_ block: () throws -> Void) -> Bool {
        do {
            try block()
            return true
        } catch {
            handle(error: error)
            return false
        }
    }
    @MainActor
    public func perform(_ block: () async throws -> Void, onError: @escaping (Error) -> Void = { _ in }) async {
        do {
            try await block()
        } catch {
            DispatchQueue.main.async {
                self.handle(error: error)
                onError(error)
            }
        }
    }
}

public struct HandleErrorsByShowingAlertViewModifier: ViewModifier {
    @ObservedObject var errorHandling: ErrorHandling
    public func body(content: Content) -> some View {
        content
            // Applying the alert for error handling using a background element
            // is a workaround, if the alert would be applied directly,
            // other .alert modifiers inside of content would not work anymore
            .background(
                EmptyView()
                    .alert(item: $errorHandling.currentAlert) { currentAlert in
                        Alert(
                            title: Text("Error"),
                            message: Text(currentAlert.message),
                            dismissButton: .default(Text("Ok")) {
                                currentAlert.dismissAction?()
                            }
                        )
                    }
            )
    }
}

public extension View {
    func withErrorHandling(handling: ErrorHandling) -> some View {
        self
            .modifier(HandleErrorsByShowingAlertViewModifier(errorHandling: handling))
            .environmentObject(handling)
    }
}
