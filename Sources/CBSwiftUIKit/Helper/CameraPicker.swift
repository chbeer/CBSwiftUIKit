//
//  CameraPicker.swift
//
//
//  Created by Christian Beer on 27.08.24.
//

import SwiftUI

#if canImport(UIKit)

public struct CameraPicker<Label: View>: View {
    
    let didPickImage: (CBImage) -> Void
    let label: () -> Label
    
    let sourceType: UIImagePickerController.SourceType = .camera
    
    @State private var showPicker = false
    
    public init(didPickImage: @escaping (CBImage) -> Void,
                label: @escaping () -> Label) {
        self.didPickImage = didPickImage
        self.label = label
    }
    
    public var body: some View {
        Button(
            action: { showPicker = true },
            label: { label() }
        )
        .sheet(isPresented: $showPicker) {
            CameraView(sourceType: sourceType, pickMovies: false) { media in
                guard case .image(let image) = media else { return }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    didPickImage(image)
                }
            }
        }
    }
}

#Preview {
    CameraPicker() { image in
    } label: {
        Image(systemName: "camera")
    }
}

#endif
