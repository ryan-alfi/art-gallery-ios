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
    
    private let disposeBag = DisposeBag()
    
    func getArtwork(request: ArtworksRequest) -> Observable<ArtworksResponseModel> {
        let queryParams = [
            URLQueryItem(name: "page", value: "\(request.page)"),
            URLQueryItem(name: "limit", value: "\(request.limit)")
        ]
        
        return NetworkRequestService.shared.executeRequest(
            urlPath: Constant.Path.artworks,
            method: .get,
            queryParams: queryParams
        )
    }
    
    func searchArtwork(withQuery keyword: String) -> Observable<[Artwork]> {
        /*return Observable.just([
            Artwork(id: 62337, title: "Francis Bacon Walking on Primrose Hill, London", artistTitle: "Bill Brandt", imageID: "c001843e-62fd-b45c-8628-3d5f7b11a018")
        ])*/
        
        return fetchSearch(keyword: keyword)
            .flatMap { (links: [SearchItem]) in
                return Observable.from(links.map { $0.apiLink })
                    .flatMap { (apiLink: String) in
                        return fetchArtwork(apiLink: apiLink)
                            .filter { $0 != nil }
                            .map {$0!}
                    }
                    .toArray()
            }
    }
    
    private func fetchSearch(keyword: String) -> Observable<[SearchItem]> {
        let queryParams = [
            URLQueryItem(name: "q", value: keyword)
        ]
        return NetworkRequestService.shared.executeRequest(
            urlPath: Constant.Path.search,
            method: .get,
            queryParams: queryParams
        ).map { (respose: SearchResponse) in
            return respose.data
        }
    }
    
    private func fetchArtwork(apiLink: String) -> Observable<Artwork?> {
        return NetworkRequestService.shared.executeRequest(baseURL: apiLink, urlPath: nil, method: .get)
            .map { (response: ArtworkDetail) in
            return response.data
        }
    }
}
