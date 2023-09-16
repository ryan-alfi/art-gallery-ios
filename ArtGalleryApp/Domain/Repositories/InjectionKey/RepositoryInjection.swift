//
//  RepositoryInjection.swift
//  ArtGalleryApp
//
//  Created by Ari Fajrianda Alfi on 16/09/23.
//

struct ArtworksRepositoryInjectionKey: InjectionKey {
    static var currentValue: ArtworksRemoteRepository = ArtworksRemoteRepositoryImpl()
}

extension InjectedValue {
    var artworksRepository: ArtworksRemoteRepository {
        get { Self[ArtworksRepositoryInjectionKey.self] }
        set { Self[ArtworksRepositoryInjectionKey.self] = newValue}
    }
}
