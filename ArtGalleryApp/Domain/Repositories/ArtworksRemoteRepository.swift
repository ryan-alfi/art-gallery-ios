//
//  ArtworksRemoteRepository.swift
//  ArtGalleryApp
//
//  Created by Ari Fajrianda Alfi on 16/09/23.
//

import RxSwift

protocol ArtworksRemoteRepository {
    func getArtwork(request: ArtworksRequest) -> Observable<ArtworksResponseModel>
    func searchArtwork(withQuery keyword: String) -> Observable<[Artwork]>
}

struct ArtworksRemoteRepositoryImpl: ArtworksRemoteRepository {
    
    @Injected(\.artworksDataSource)
    var artworksDataSource: ArtworksDataSource
    
    func getArtwork(request: ArtworksRequest) -> Observable<ArtworksResponseModel> {
        return artworksDataSource.getArtwork(request: request)
    }
    
    func searchArtwork(withQuery keyword: String) -> Observable<[Artwork]> {
        return artworksDataSource.searchArtwork(withQuery: keyword)
    }
}
