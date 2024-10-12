//
//  PhotoPicker.swift
//
//
//  Created by Christian Beer on 03.03.24.
//

import SwiftUI
import PhotosUI

public struct PhotoPicker<Label: View>: View {

    @State private var selectedItem: PhotosPickerItem?
        
    let didPickImage: (CBImage) -> Void
    let label: () -> Label
    
    public init(didPickImage: @escaping (CBImage) -> Void,
         label: @escaping () -> Label) {
        self.didPickImage = didPickImage
        self.label = label
    }
    
    public var body: some View {
        PhotosPicker(selection: $selectedItem) {
            label()
        }
        .onChange(of: selectedItem) {
            Task {
                if let data = try? await selectedItem?.loadTransferable(type: Data.self),
                    let image = CBImage(data: data) {
                    didPickImage(image)
                }
            }
        }
    }
}

#Preview {
    PhotoPicker() { image in
    } label: {
        Image(systemName: "camera")
    }
}
