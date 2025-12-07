//
//  CBUIColorWell.swift
//  CBSwiftUIKit
//
//  Created by Christian Beer on 07.12.25.
//

#if !os(macOS)

import UIKit

public class CBUIColorWell: UIButton, UIColorPickerViewControllerDelegate {
    
    public var selectedColor: UIColor? {
        didSet {
            setNeedsDisplay()
            if oldValue != selectedColor {
                sendActions(for: .valueChanged)
            }
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        layer.cornerRadius = 8
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.separator.cgColor
        addTarget(self, action: #selector(openColorPicker), for: .touchUpInside)
    }
    
    // Drawing the color or slash
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let color = selectedColor, color != .clear, color.cgColor.alpha != 0 else {
            drawSlash(in: rect)
            return
        }
        
        let path = UIBezierPath(roundedRect: rect.insetBy(dx: 2, dy: 2), cornerRadius: 8)
        color.setFill()
        path.fill()
    }
    
    private func drawSlash(in rect: CGRect) {
        let path = UIBezierPath()
        path.lineWidth = 1
        UIColor.separator.setStroke()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.stroke()
    }
    
    // MARK: - Picker Presentation
    
    @objc private func openColorPicker() {
        guard let vc = nearestViewController else { return }
        
        let picker = UIColorPickerViewController()
        picker.delegate = self
        picker.supportsAlpha = true
        picker.selectedColor = selectedColor ?? .clear
        
        // Sheet presentation on iOS 15+
        if let sheet = picker.sheetPresentationController {
            sheet.detents = [.medium()]           // Fit content height
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }
        
        vc.present(picker, animated: true)
    }
    
    // Finds the nearest view controller in the responder chain
    private var nearestViewController: UIViewController? {
        var r: UIResponder? = self
        while let next = r?.next {
            if let vc = next as? UIViewController { return vc }
            r = next
        }
        return nil
    }
    
    // MARK: - UIColorPickerViewControllerDelegate
    
    public func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        selectedColor = viewController.selectedColor
    }
    public func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        // Same behavior as UIColorWell — update one last time
        selectedColor = viewController.selectedColor
    }
}

#endif
