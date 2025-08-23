//
//  GlassEffect.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 17.08.25.
//

import SwiftUI

extension Backport where Content: View {
    
    /// Applies a glass effect to this view.
    ///
    /// When you use a glass effect, the platform:
    ///   - Renders a shape anchored behind this view filled with
    ///     the physical glass material
    ///   - Applies the foreground effects of the glass over this view.
    ///
    /// For example, you could add a glass effect to a ``Label``:
    ///
    ///     Label("Flag", systemImage: "flag.fill")
    ///         .padding()
    ///         .glassEffect()
    ///
    /// SwiftUI uses the ``Glass/regular`` variant by default along with
    /// a ``Capsule`` shape.
    ///
    /// SwiftUI anchors the glass to the view's bounds. For the example
    /// above, the physical glass material fills the entirety of the label's
    /// frame, which includes the padding.
    ///
    /// You typically use this modifier with a ``GlassEffectContainer``
    /// to combine multiple glass shapes into a single shape that
    /// can morph shapes into one another.
    @available(visionOS, unavailable)
    @ViewBuilder
    nonisolated public func glassEffect(_ glass: Backport<Any>.Glass = .regular) -> some View {
        if #available(iOS 26, macOS 26, *) {
            content.glassEffect(glass.backported)
        } else {
            content
        }
    }
}

extension Backport where Content == Any {
    
    /// A structure that defines the configuration of a physical glass material.
    ///
    /// You provide instances of glass to the ``View/glassEffect(_:in)``
    /// view modifier which:
    ///
    ///      Label("Flag", systemImage: "flag.fill")
    ///          .padding()
    ///          .glassEffect()
    ///
    /// You can combine glass effects by using a ``GlassEffectContainer``
    /// which supports morphing glass shapes into each other based on
    /// the geometry of their associated views.
    @available(visionOS, unavailable)
    public struct Glass : Sendable {
        
        enum GlassType: Int {
            case regular, clear, identity
        }
        
        let glassType: GlassType
        let tint: Color?
        let interactive: Bool
        
        /// The regular variant of glass.
        ///
        /// The regular variant of glass automatically maintains legibility
        /// of content by adjusting its content based on the luminosity of the
        ///  content beneath the glass.
        public static var regular: Glass {
            .init(glassType: .regular, tint: nil, interactive: false)
        }
        
        /// The clear variant of glass.
        ///
        /// When using clear glass, ensure content remains legible by adding a
        /// dimming layer or other treatment beneath the glass.
        ///
        /// For example, you could add a transparent black color beneath your
        /// glass to ensure content remains legible above the glass.
        ///
        ///     Label("Flag", systemImage: "flag.fill")
        ///         .padding()
        ///         .glassEffect(.clear)
        ///         .background(.black.opacity(0.3))
        ///
        public static var clear: Glass {
            .init(glassType: .clear, tint: nil, interactive: false)
        }
        
        /// The identity variant of glass. When applied, your content
        /// remains unaffected as if no glass effect was applied.
        public static var identity: Glass  {
            .init(glassType: .identity, tint: nil, interactive: false)
        }
        
        /// Returns a copy of the glass with the provided tint color.
        public func tint(_ color: Color?) -> Glass {
            .init(glassType: self.glassType, tint: color, interactive: self.interactive)
        }
        
        /// Returns a copy of the glass configured to be interactive.
        public func interactive(_ isEnabled: Bool = true) -> Glass {
            .init(glassType: self.glassType, tint: self.tint, interactive: isEnabled)
        }
        
        @available(iOS 26, macOS 26, *)
        var backported: SwiftUI.Glass {
            switch self.glassType {
            case .regular: return .regular.tint(self.tint).interactive(self.interactive)
            case .clear: return .clear.tint(self.tint).interactive(self.interactive)
            case .identity: return .identity.tint(self.tint).interactive(self.interactive)
            }
        }
    }
    
}
