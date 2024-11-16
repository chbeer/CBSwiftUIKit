//
//  MediaPicker.swift
//
//
//  Created by Christian Beer on 20.02.24.
//

import SwiftUI
import MediaPlayer

#if os(iOS)

import UIKit

public extension View {
    @ViewBuilder
    func mediaPicker(
        isPresented showMediaPicker: Binding<Bool>,
        mediaTypes: MPMediaType,
        allowsPickingMultipleItems: Bool = false,
        showsCloudItems: Bool = true,
        showsItemsWithProtectedAssets: Bool = true,
        prompt: String? = nil,
        resultsHandler: @escaping (MPMediaItemCollection) -> Void
    ) -> some View {
        self.sheet(isPresented: showMediaPicker) {
            MediaPicker(
                mediaTypes: mediaTypes,
                allowsPickingMultipleItems: allowsPickingMultipleItems,
                showsCloudItems: showsCloudItems,
                showsItemsWithProtectedAssets: showsItemsWithProtectedAssets,
                prompt: prompt
            ) {
                resultsHandler($0)
                showMediaPicker.wrappedValue = false
            }
        }
    }
}

public struct MediaPicker: UIViewControllerRepresentable {

    public typealias UIViewControllerType = MPMediaPickerController
    
    let mediaTypes: MPMediaType
    let allowsPickingMultipleItems: Bool
    let showsCloudItems: Bool
    let showsItemsWithProtectedAssets: Bool
    let prompt: String?
    let resultsHandler: (MPMediaItemCollection) -> Void
    
    public init(
        mediaTypes: MPMediaType,
        allowsPickingMultipleItems: Bool = false,
        showsCloudItems: Bool = true,
        showsItemsWithProtectedAssets: Bool = true,
        prompt: String? = nil,
        resultsHandler: @escaping (MPMediaItemCollection) -> Void
    ) {
        self.mediaTypes = mediaTypes
        self.allowsPickingMultipleItems = allowsPickingMultipleItems
        self.showsCloudItems = showsCloudItems
        self.showsItemsWithProtectedAssets = showsItemsWithProtectedAssets
        self.prompt = prompt
        self.resultsHandler = resultsHandler
    }

    public func makeUIViewController(context: Context) -> MPMediaPickerController {
        let ctrl = MPMediaPickerController(mediaTypes: mediaTypes)
        ctrl.delegate = context.coordinator
        ctrl.allowsPickingMultipleItems = allowsPickingMultipleItems
        ctrl.showsCloudItems = showsCloudItems
        ctrl.showsItemsWithProtectedAssets = showsItemsWithProtectedAssets
        ctrl.prompt = prompt
        return ctrl
    }
    
    public func updateUIViewController(_ uiViewController: MPMediaPickerController, context: Context) {
    }
    
    public func makeCoordinator() -> Coordinator {
        return Coordinator() {
            self.resultsHandler($0)
        }
    }

    public class Coordinator: NSObject, MPMediaPickerControllerDelegate {
        
        var resultsHandler: (MPMediaItemCollection) -> Void
        
        init(resultsHandler: @escaping (MPMediaItemCollection) -> Void) {
            self.resultsHandler = resultsHandler
        }
        
        public func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
            resultsHandler(mediaItemCollection)
        }
        
    }
}

//#Preview {
//    MediaPicker()
//}

#endif
