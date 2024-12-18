//
//  SwiftUIView.swift
//  
//
//  Created by Christian Beer on 20.08.23.
//

import SwiftUI

public extension Bool {
#if canImport(AppKit)
    
    static var macOS: Bool {
        return true
    }
    static var iOS: Bool {
        return false
    }
    static var iPad: Bool {
        return false
    }

#else
    
    static var macOS: Bool {
        return false
    }
    static var iOS: Bool {
        return true
    }
    static var iPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
#endif
}
