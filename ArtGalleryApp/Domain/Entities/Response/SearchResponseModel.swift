//
//  SearchResponseModel.swift
//  ArtGalleryApp
//
//  Created by Ari Fajrianda Alfi on 16/09/23.
//

import Foundation

struct SearchResponse: Codable {
    let data: [NextLink]
}

struct NextLink: Codable {
    let apiLink: String
    let id: Int

    enum CodingKeys: String, CodingKey {
        case apiLink = "api_link"
        case id
    }
}

struct ArtworkDetail: Codable {
    let data: Artwork
}
