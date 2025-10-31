//
//  UIMenu+Localization.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 08.09.25.
//

#if canImport(UIKit)

import UIKit
import SwiftUI

public extension UIMenu {
    
    @available(watchOS, unavailable)
    @MainActor @preconcurrency convenience init(_ title: String.LocalizationValue = "", subtitle: String.LocalizationValue? = nil, image: UIImage? = nil, identifier: UIMenu.Identifier? = nil, options: UIMenu.Options = [], preferredElementSize: UIMenu.ElementSize = { if #available(iOS 17.0, tvOS 17.0, watchOS 10.0, *) { .automatic } else { .large } }(), children: [UIMenuElement] = []) {
        self.init(
            title: String(localized: title),
            subtitle: subtitle.map { String(localized: $0) },
            image: image,
            identifier: identifier,
            options: options,
            preferredElementSize: preferredElementSize,
            children: children
        )
    }
    
}

public extension UIAction {
    
    @available(watchOS, unavailable)
    @MainActor @preconcurrency convenience init(_ title: String.LocalizationValue = "", subtitle: String.LocalizationValue? = nil, image: UIImage? = nil, selectedImage: UIImage? = nil, identifier: UIAction.Identifier? = nil, discoverabilityTitle: String.LocalizationValue? = nil, attributes: UIMenuElement.Attributes = [], state: UIMenuElement.State = .off, handler: @escaping UIActionHandler) {
        self.init(
            title: String(localized: title),
            subtitle: subtitle.map { String(localized: $0) },
            image: image,
            selectedImage: selectedImage,
            identifier: identifier,
            discoverabilityTitle: discoverabilityTitle.map { String(localized: $0) },
            attributes: attributes,
            state: state,
            handler: handler
        )
    }
    
}

public extension UICommand {
    
    @MainActor @preconcurrency convenience init(_ title: String.LocalizationValue = "", subtitle: String.LocalizationValue? = nil, image: UIImage? = nil, selectedImage: UIImage? = nil, action: Selector, propertyList: Any? = nil, alternates: [UICommandAlternate] = [], discoverabilityTitle: String.LocalizationValue? = nil, attributes: UIMenuElement.Attributes = [], state: UIMenuElement.State = .off) {
        self.init(
            title: String(localized: title),
            subtitle: subtitle.map { String(localized: $0) },
            image: image,
            selectedImage: selectedImage,
            action: action,
            propertyList: propertyList,
            alternates: alternates,
            discoverabilityTitle: discoverabilityTitle.map { String(localized: $0) },
            attributes: attributes,
            state: state
        )
    }
    
}


#endif
