//
//  ImagePickingSupport.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 06.12.24.
//

import SwiftUI
import PhotosUI

public typealias PhotoHandler = (CBImage) -> Void

public struct PhotoAction {
    public enum Action {
        case pickPhoto, takePhoto
    }
    
    let action: Action
    let handler: PhotoHandler
    
    public init(action: Action, handler: @escaping PhotoHandler) {
        self.action = action
        self.handler = handler
    }
}

public struct PhotoActionSupport: ViewModifier {

    @Binding var action: PhotoAction?
    
    @State var showPhotosPicker = false
    @State var pickedPhoto: PhotosPickerItem? = nil
    
    @State var showCameraPicker = false
    
    @ViewBuilder @MainActor
    public func body(content: Content) -> some View {
        content
            .photosPicker(isPresented: $showPhotosPicker, selection: $pickedPhoto)
        #if os(macOS)
            .onChange(of: showCameraPicker) { _, newValue in
                
            }
        #else
            .sheet(isPresented: $showCameraPicker) {
                CameraView(pickMovies: false) { media in
                    guard case .image(let image) = media else { return }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        action?.handler(image)
                    }
                }
            }
        #endif
            .onChange(of: pickedPhoto) { _, newValue in
                if let newValue {
                    Task {
                        if let data = try? await newValue.loadTransferable(type: Data.self),
                           let image = CBImage(data: data) {
                            action?.handler(image)
                        }
                    }
                }
            }
            .onChange(of: action) { _, newValue in
                if let newValue {
                    switch newValue.action {
                    case .pickPhoto: showPhotosPicker = true
                    case .takePhoto: showCameraPicker = true
                    }
                }
            }
        }
}

extension View {
    public func photoActionSupport(action: Binding<PhotoAction?>) -> some View {
        modifier(PhotoActionSupport(action: action))
    }
}

extension PhotoAction: Equatable {
    public static func == (lhs: PhotoAction, rhs: PhotoAction) -> Bool {
        return lhs.action == rhs.action
    }
}
