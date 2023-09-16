//
//  ArtworksDataSource.swift
//  ArtGalleryApp
//
//  Created by Ari Fajrianda Alfi on 16/09/23.
//

import Foundation
import RxSwift

protocol ArtworksDataSource {
    func getArtwork(request: ArtworksRequest) -> Observable<ArtworksResponseModel>
    func searchArtwork(withQuery keyword: String) -> Observable<[Artwork]>
}

struct ArtworksDataSourceImpl: ArtworksDataSource {
    
    private let networkService: NetworkRequestService
    
    init(networkService: NetworkRequestService = NetworkRequestService.shared) {
        self.networkService = networkService
    }
    
    func getArtwork(request: ArtworksRequest) -> Observable<ArtworksResponseModel> {
        let queryParams = [
            URLQueryItem(name: "page", value: "\(request.page)"),
            URLQueryItem(name: "limit", value: "\(request.limit)")
        ]
        
        return networkService.executeRequest(
            urlPath: Constant.Path.artworks,
            method: .get,
            queryParams: queryParams
        )
    }
    
    func searchArtwork(withQuery keyword: String) -> Observable<[Artwork]> {
        return Observable.just([
            Artwork(id: 62337, title: "Francis Bacon Walking on Primrose Hill, London", artistTitle: "Bill Brandt", imageID: "c001843e-62fd-b45c-8628-3d5f7b11a018")
        ])
    }
}
