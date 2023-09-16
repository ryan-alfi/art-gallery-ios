//
//  UseCaseInjection.swift
//  ArtGalleryApp
//
//  Created by Ari Fajrianda Alfi on 16/09/23.
//

struct ArtworksUseCaseInjectionKey: InjectionKey {
    static var currentValue: GetListArtworksUseCase = GetListArtworksUseCaseImpl()
}

extension InjectedValue {
    var getListArtworksUseCase: GetListArtworksUseCase {
        get { Self[ArtworksUseCaseInjectionKey.self] }
        set { Self[ArtworksUseCaseInjectionKey.self] = newValue }
    }
}
