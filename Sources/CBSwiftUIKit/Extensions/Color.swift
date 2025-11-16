//
//  Color.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 16.11.25.
//

import SwiftUI

#if canImport(UIKit)
import UIKit

public extension Color {
    
    var cbColor: CBColor? {
        UIColor(self)
    }
    
}

#elseif canImport(AppKit)
import AppKit

public extension Color {
    
    var cbColor: CBColor? {
        NSColor(self)
    }
    
}

#endif

