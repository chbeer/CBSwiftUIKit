//
//  UICommand+Tag.swift
//  iVocabulary4
//
//  Created by Christian Beer on 08.09.25.
//

#if !os(macOS)

import UIKit

public extension UICommand {
    
    @MainActor @preconcurrency convenience init(
        _ title: String.LocalizationValue = "",
        subtitle: String.LocalizationValue? = nil,
        image: UIImage? = nil,
        selectedImage: UIImage? = nil,
        action: Selector,
        tag: Int? = nil,
        alternates: [UICommandAlternate] = [],
        discoverabilityTitle: String.LocalizationValue? = nil,
        attributes: UIMenuElement.Attributes = [],
        state: UIMenuElement.State = .off
    ) {
        self.init(
            title: String(localized: title),
            subtitle: subtitle.map { String(localized: $0) },
            image: image,
            selectedImage: selectedImage,
            action: action,
            propertyList: tag,
            alternates: alternates,
            discoverabilityTitle: discoverabilityTitle.map { String(localized: $0) },
            attributes: attributes,
            state: state
        )
    }
    
    @MainActor @preconcurrency convenience init(
        _ title: String = "",
        subtitle: String? = nil,
        image: UIImage? = nil,
        selectedImage: UIImage? = nil,
        action: Selector,
        tag: Int? = nil,
        alternates: [UICommandAlternate] = [],
        discoverabilityTitle: String? = nil,
        attributes: UIMenuElement.Attributes = [],
        state: UIMenuElement.State = .off
    ) {
        self.init(
            title: title,
            subtitle: subtitle,
            image: image,
            selectedImage: selectedImage,
            action: action,
            propertyList: tag,
            alternates: alternates,
            discoverabilityTitle: discoverabilityTitle,
            attributes: attributes,
            state: state
        )
    }
    
}

#endif
