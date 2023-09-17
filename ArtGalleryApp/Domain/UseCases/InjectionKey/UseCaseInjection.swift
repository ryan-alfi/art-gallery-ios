//
//  UseCaseInjection.swift
//  ArtGalleryApp
//
//  Created by Ari Fajrianda Alfi on 16/09/23.
//

struct ArtworksUseCaseInjectionKey: InjectionKey {
    static var currentValue: GetListArtworksUseCase = GetListArtworksUseCaseImpl()
}

struct SearchArtworksUseCaseInjectionKey: InjectionKey {
    static var currentValue: SearchArtworksUseCase = SearchArtworksUseCaseImpl()
}

extension InjectedValue {
    var getListArtworksUseCase: GetListArtworksUseCase {
        get { Self[ArtworksUseCaseInjectionKey.self] }
        set { Self[ArtworksUseCaseInjectionKey.self] = newValue }
    }
    
    var searchArworksUseCase: SearchArtworksUseCase {
        get { Self[SearchArtworksUseCaseInjectionKey.self] }
        set { Self[SearchArtworksUseCaseInjectionKey.self] = newValue }
    }
}
