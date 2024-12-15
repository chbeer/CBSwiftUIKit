//
//  Untitled.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 06.12.24.
//

#if os(macOS)

import SwiftUI
import AppKit
import Quartz

struct CameraView: NSViewRepresentable {
    
    let pickMovies: Bool
    let didPick: (Media) -> Void

    public func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    public func makeNSView(context: Context) -> IKCameraDeviceView {
        let view = IKCameraDeviceView()
        
        return view
    }
    
    public func updateNSView(_ nsView: IKCameraDeviceView, context: Context) {
    }
    
    public class Coordinator: NSObject {
        
    }
}

#endif
