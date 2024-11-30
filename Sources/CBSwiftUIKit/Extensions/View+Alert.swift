//
//  View+Alert.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 20.11.24.
//

import SwiftUI
import Combine

struct AlertWithItemModifier<Item : Equatable, A: View>: ViewModifier {
    let titleKey: LocalizedStringKey
    let item: Binding<Item?>
    @ViewBuilder let actions: (Item) -> A
    
    @State var isPresented: Bool = false
    
    init(_ titleKey: LocalizedStringKey, item: Binding<Item?>, actions: @escaping (Item) -> A) {
        self.titleKey = titleKey
        self.item = item
        self.actions = actions
    }
    
    public func body(content: Content) -> some View {
        content
            .onReceive(Just(item)) { item in
                isPresented = item.wrappedValue != nil
            }
            .alert(titleKey, isPresented: $isPresented) {
                if let item = item.wrappedValue {
                    actions(item)
                }
            }
    }
}
        
public extension View {
    func alert<Item: Equatable, A: View>(_ item: Binding<Item?>, title: LocalizedStringKey, @ViewBuilder actions: @escaping (Item) -> A) -> some View {
        modifier(AlertWithItemModifier(title, item: item, actions: actions))
    }
}
