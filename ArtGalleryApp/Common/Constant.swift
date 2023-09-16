//
//  Constant.swift
//  ArtGalleryApp
//
//  Created by Ari Fajrianda Alfi on 16/09/23.
//

import Foundation

internal struct Constant {
    struct URL {
        static let baseURL: String = "https://api.artic.edu/api/v1"
    }
    
    struct Path {
        static let artworks: String = "/artworks"
        static let search: String = "/artworks/search"
    }
}
