//
//  CameraView.swift
//
//
//  Created by Christian Beer on 08.12.22.
//

import SwiftUI

#if os(iOS)

struct CameraView: UIViewControllerRepresentable {
    
    enum Media {
        case image(UIImage)
        case movie(URL)
    }
    
    @Environment(\.presentationMode) var isPresented
    let sourceType: UIImagePickerController.SourceType
    let pickMovies: Bool
    let didPick: (Media) -> Void
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = self.sourceType
        imagePicker.delegate = context.coordinator // confirming the delegate
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    // Connecting the Coordinator class with this struct
    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
    
    // MARK: -
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var picker: CameraView
        
        init(picker: CameraView) {
            self.picker = picker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if info[.mediaType] as? String == "public.movie" {
                guard let url = info[.mediaURL] as? URL else { return }
                self.picker.didPick(.movie(url))
            } else {
                guard let selectedImage = info[.originalImage] as? UIImage else { return }
                self.picker.didPick(.image(selectedImage))
            }
            
            self.picker.isPresented.wrappedValue.dismiss()
        }
        
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView(sourceType: .photoLibrary, pickMovies: false) { _ in }
    }
}

#endif
