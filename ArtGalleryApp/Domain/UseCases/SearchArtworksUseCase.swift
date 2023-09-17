//
//  SearchArtworksUseCase.swift
//  ArtGalleryApp
//
//  Created by Ari Fajrianda Alfi on 17/09/23.
//

import RxSwift

protocol SearchArtworksUseCase {
    func execute(keyword: String) -> Observable<[Artwork]>
}

struct SearchArtworksUseCaseImpl: SearchArtworksUseCase {
    
    @Injected(\.artworksRepository)
    var repository: ArtworksRemoteRepository
    
    func execute(keyword: String) -> Observable<[Artwork]> {
        return repository.searchArtwork(withQuery: keyword)
    }
    
}
