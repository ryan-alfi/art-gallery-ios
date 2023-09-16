//
//  GetListArtworksUseCase.swift
//  ArtGalleryApp
//
//  Created by Ari Fajrianda Alfi on 16/09/23.
//

import RxSwift

protocol GetListArtworksUseCase {
    func execute(request: ArtworksRequest) -> Observable<ArtworksResponseModel>
}

struct GetListArtworksUseCaseImpl: GetListArtworksUseCase {
    
    @Injected(\.artworksRepository)
    var repository: ArtworksRemoteRepository
    
    func execute(request: ArtworksRequest) -> Observable<ArtworksResponseModel> {
        return repository.getArtwork(request: request)
    }
    
}
