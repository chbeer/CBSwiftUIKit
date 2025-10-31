//
//  NavigationTransition.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 17.08.25.
//

import SwiftUI

public extension Backport where Content: View {
    @ViewBuilder func navigationTransition(_ style: some BPNavigationTransition) -> some View {
//        if #available(iOS 18, macOS 15, *) {
//            content.navigationTransition(style.backported)
//        } else {
            content
//        }
    }
}

public protocol BPNavigationTransition {
    @available(iOS 18, macOS 15, *)
    var backported: NavigationTransition { get }
}

public extension BPNavigationTransition where Self == BPAutomaticNavigationTransition {
    /// A style that automatically chooses the appropriate presentation
    /// transition for the current context.
    static var automatic: BPAutomaticNavigationTransition {
        .init()
    }
}
public extension BPNavigationTransition where Self == BPZoomNavigationTransition {
    /// A navigation transition that zooms the appearing view from a
    /// given source view.
    ///
    /// Indicate the source view using the
    /// ``View/matchedTransitionSource(id:namespace:)`` modifier.
    ///
    /// - Parameters:
    ///   - sourceID: The identifier you provide to a corresponding
    ///     `matchedTransitionSource` modifier.
    ///   - namespace: The namespace where you define the `id`. You can create
    ///     new namespaces by adding the ``Namespace`` attribute
    ///     to a ``View`` type, then reading its value in the view's body
    ///     method.
    static func zoom(sourceID: some Hashable, in namespace: Namespace.ID) -> BPZoomNavigationTransition {
        .init(sourceID: sourceID, namespace: namespace)
    }
}

public struct BPAutomaticNavigationTransition : BPNavigationTransition {
    @available(iOS 18, macOS 15, *)
    public var backported: any NavigationTransition { .automatic }
}
public struct BPZoomNavigationTransition : BPNavigationTransition {
    
    let sourceID: any Hashable
    let namespace: Namespace.ID
    
    @available(iOS 18, macOS 15.0, *)
    public var backported: any NavigationTransition {
#if os(iOS)
        .zoom(sourceID: sourceID, in: namespace)
#else
        .automatic
#endif
    }
    
}
