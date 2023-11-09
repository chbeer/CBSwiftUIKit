//
//  SwiftUIView.swift
//
//
//  Created by Christian Beer on 07.11.23.
//

import SwiftUI

public extension Image {
    
    init(data: Data) {
#if canImport(UIKit)
        let image = UIImage(data: data) ?? UIImage()
        self.init(uiImage: image)
#elseif canImport(AppKit)
        let image = NSImage(data: data) ?? NSImage()
        self.init(nsImage: image)
#else
        return Image()
#endif
    }
    
}
