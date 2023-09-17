//
//  UIView+Ext.swift
//  ArtGalleryApp
//
//  Created by Ari Fajrianda Alfi on 17/09/23.
//

import UIKit

extension UIView {

    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
    
}
