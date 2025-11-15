//
//  AsyncButton.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 15.11.24.
//

import SwiftUI

public struct AsyncButton<Label>: View where Label: View {

    public typealias Action = @Sendable @MainActor () async throws -> Void
    public typealias ErrorHandler = (Error) -> Void

    private let action: Action
    private let onError: ErrorHandler
    private let label: Label

    @State private var isActive: Bool = false

    public init(
        action: @escaping Action,
        onError: @escaping ErrorHandler,
        @ViewBuilder label: () -> Label
    ) {
        self.action = action
        self.onError = onError
        self.label = label()
    }

    public var body: some View {
        Button {
            isActive = true
            Task<Void, Never> {
                do {
                    try await self.action()
                    isActive = false
                } catch let error as NSError {
                    isActive = false
                    self.onError(error)
                }
            }
        } label: {
            self.label
                .padding(.horizontal, 30)
                .overlay(alignment: .leading) {
                    if isActive {
                        ProgressView()
                            .controlSize(.small)
                        
                    }
                }
        }
        .disabled(isActive)
    }

}

