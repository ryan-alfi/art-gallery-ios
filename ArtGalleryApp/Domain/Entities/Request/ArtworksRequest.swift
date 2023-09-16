//
//  ArtworksRequest.swift
//  ArtGalleryApp
//
//  Created by Ari Fajrianda Alfi on 16/09/23.
//

import Foundation

struct ArtworksRequest: Codable {
    let page: Int
    let limit: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case limit
    }
}
