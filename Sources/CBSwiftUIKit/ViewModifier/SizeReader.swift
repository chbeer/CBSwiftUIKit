//
//  SizeReader.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 11.12.24.
//

import SwiftUI

public extension View {
    func sizeReader(_ size: Binding<CGSize>) -> some View {
        modifier(SizeReader(size: size))
    }
}
public struct SizeReader: ViewModifier {
    @Binding var size: CGSize

    public func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            self.size = proxy.size
                        }
                }
            )
    }
}
