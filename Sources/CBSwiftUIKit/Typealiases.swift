//
//  Typealiases.swift
//
//
//  Created by Christian Beer on 24.07.24.
//

#if canImport(UIKit)
import UIKit
public typealias CBRect = CGRect
public typealias CBImage = UIImage
public typealias CBColor = UIColor
public typealias CBFont = UIFont
public typealias CBFontDescriptor = UIFontDescriptor
public typealias CBCollectionView = UICollectionView
#else
import AppKit
public typealias CBRect = NSRect
public typealias CBImage = NSImage
public typealias CBColor = NSColor
public typealias CBFont = NSFont
public typealias CBFontDescriptor = NSFontDescriptor
public typealias CBCollectionView = NSCollectionView
#endif
