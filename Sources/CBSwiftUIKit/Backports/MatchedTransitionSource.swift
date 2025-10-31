//
//  MatchedTransitionSource.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 17.08.25.
//

import Foundation
import SwiftUI

public extension Backport where Content: View {
    @ViewBuilder func matchedTransitionSource(id: any Hashable, in namespace: Namespace.ID) -> some View {
//        if #available(iOS 18, macOS 15, *) {
//            content.matchedTransitionSource(id: id, in: namespace)
//        } else {
            content
//        }
    }
}
