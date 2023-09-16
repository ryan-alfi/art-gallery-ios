//
//  ArtworksResponseModel.swift
//  ArtGalleryApp
//
//  Created by Ari Fajrianda Alfi on 16/09/23.
//

import Foundation

struct ArtworksResponseModel: Codable {
    let data: [Artwork]
    let pagination: Pagination
}

struct Artwork: Codable {
    let id: Int
    let title: String
    let artistTitle: String?
    let imageID: String?
    
    var imageUrl: URL {
        if let imageID {
            return URL(string: "https://www.artic.edu/iiif/2/\(imageID)/full/843,/0/default.jpg")!
        } else {
            return URL(string: "https://ps.w.org/replace-broken-images/assets/icon-256x256.png?rev=2561727")!
        }
    }

    enum CodingKeys: String, CodingKey {
        case id, title
        case artistTitle = "artist_title"
        case imageID = "image_id"
    }
}

struct Pagination: Codable {
    let total, limit, currentPage: Int
    
    enum CodingKeys: String, CodingKey {
        case total, limit
        case currentPage = "current_page"
    }
}
