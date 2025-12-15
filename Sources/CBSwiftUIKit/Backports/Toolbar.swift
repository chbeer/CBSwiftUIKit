//
//  Toolbar.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 15.12.25.
//

import SwiftUI

public extension Backport where Content: ToolbarContent {
    
    @ToolbarContentBuilder
    nonisolated func sharedBackgroundVisibility(_ visibility: Backport<Any>.Visibility) -> some ToolbarContent {
        if #available(iOS 26, macOS 26, *) {
            content.sharedBackgroundVisibility(visibility.backported)
        } else {
            content
        }
    }
    
}

extension Backport where Content == Any {
 
    public enum Visibility: Equatable {
        case automatic
        case visible
        case hidden
        
        @available(iOS 26, macOS 26, *)
        var backported: SwiftUI.Visibility {
            switch self {
            case .automatic: return .automatic
            case .visible: return .visible
            case .hidden: return .hidden
            }
        }
    }
    
}
