//
//  SettingsFormStyle.swift
//
//  Created by Christian Beer on 23.01.26.
//

import SwiftUI

// Found: https://github.com/objcio/S01E475-settings-form-layout-part-2/blob/main/SettingsForm/ContentView.swift

@available(iOS 18.0, macOS 15.0, *)
public struct SettingsFormStyle: FormStyle {
    
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        Grid {
            Group(sections: configuration.content) { sections in
                ForEach(sections) { section in
                    GridRow(alignment: .firstTextBaseline) {
                        section.header
                            .font(.headline)
                            .gridColumnAlignment(.trailing)
                        VStack(alignment: .leading) {
                            section.content
                            section.footer
                                .foregroundStyle(.primary)
                        }
                        .gridColumnAlignment(.leading)
                    }
                    if section.id != sections.last?.id {
                        Divider()
                            .gridCellUnsizedAxes(.horizontal)
                    }
                }
            }
        }
    }
    
}
