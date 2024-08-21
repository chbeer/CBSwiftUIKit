//
//  File.swift
//  
//
//  Created by Christian Beer on 07.06.24.
//

import Foundation
import SwiftUI

#if canImport(UIKit)

import UIKit

// Taken from: https://sarunw.com/posts/xcode-previews-with-uiviewcontroller/

public struct PreviewContainer<T: UIViewController>: UIViewControllerRepresentable {

    let viewController: T
    
    public init(_ viewControllerBuilder: @escaping () -> T) {
        viewController = viewControllerBuilder()
    }
    
    // MARK: - UIViewControllerRepresentable
    public func makeUIViewController(context: Context) -> T {
        return viewController

    }
    
    public func updateUIViewController(_ uiViewController: T, context: Context) {}
}

#endif
