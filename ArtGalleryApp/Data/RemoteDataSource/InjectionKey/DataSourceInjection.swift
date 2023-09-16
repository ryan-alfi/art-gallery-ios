//
//  DataSourceInjection.swift
//  ArtGalleryApp
//
//  Created by Ari Fajrianda Alfi on 16/09/23.
//

struct ArtworksDataSourceInjectionKey: InjectionKey {
    static var currentValue: ArtworksDataSource = ArtworksDataSourceImpl()
}

extension InjectedValue {
    var artworksDataSource: ArtworksDataSource {
        get { Self[ArtworksDataSourceInjectionKey.self] }
        set { Self[ArtworksDataSourceInjectionKey.self] = newValue }
    }
}
