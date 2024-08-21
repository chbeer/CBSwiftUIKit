//
//  SwiftUIView.swift
//  
//
//  Created by Christian Beer on 20.08.23.
//

import SwiftUI

public extension Bool {
    static var macOS: Bool {
#if canImport(AppKit)
        return true
#else
        return false
#endif
    }
    
    static var iOS: Bool {
#if canImport(UIKit)
        return true
#else
        return false
#endif
    }
}
