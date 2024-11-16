//
//  LabeledSlider.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 27.09.23.
//

import SwiftUI

public struct LabeledSlider: View {
    
    let title: LocalizedStringKey
    let value: Binding<Float>
    let range: ClosedRange<Float>
    let minLabel: LocalizedStringKey
    let maxLabel: LocalizedStringKey
    
    public init(title: LocalizedStringKey, value: Binding<Float>, range: ClosedRange<Float> = 0...1, minLabel: LocalizedStringKey, maxLabel: LocalizedStringKey) {
        self.title = title
        self.value = value
        self.range = range
        self.minLabel = minLabel
        self.maxLabel = maxLabel
    }
    public var body: some View {
        VStack(alignment: .leading) {
            Text(title)
#if os(tvOS)
#else
            Slider(value: value, in: range) {
                Text(title)
            }
#if os(macOS)
            .labelsHidden()
#endif
#endif
            HStack {
                Text(minLabel)
                Spacer()
                Text(maxLabel)
            }
            .font(.caption)
        }
    }
}

#Preview {
    LabeledSlider(
        title: "Test", value: .constant(0.5), range: 0...1, minLabel: "Min", maxLabel: "Max"
    )
}
