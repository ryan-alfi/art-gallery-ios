//
//  SearchViewModel.swift
//  ArtGalleryApp
//
//  Created by Ari Fajrianda Alfi on 16/09/23.
//

import RxSwift

final class SearchViewModel: BaseViewModel {
    
    @Injected(\.getListArtworksUseCase) var getListArtworksUseCase: GetListArtworksUseCase
    @Injected(\.searchArworksUseCase) var searchArtworksUseCase: SearchArtworksUseCase
    
    var scheduler: ImmediateSchedulerType = MainScheduler.asyncInstance
    
    let artworksDataSubject = PublishSubject<ArtworksResponseModel>()
    private var artworksData = [Artwork]()
    
    let searchStateSubject = BehaviorSubject<LoadingState>(value: .success)
    let searchDataSubject = PublishSubject<[Artwork]>()
    
    func getListArtworks(page: Int = 1) {
        self.stateSubject.onNext(.loading)
        
        let request: ArtworksRequest = ArtworksRequest(page: page, limit: 15)
        
        getListArtworksUseCase.execute(request: request).observe(on: scheduler)
            .subscribe { response in
                self.stateSubject.onNext(.success)
                self.artworksDataSubject.onNext(response)
            } onError: { error in
                self.stateSubject.onNext(.failed)
                debugPrint("getListArtworks error:\(error)")
            }.disposed(by: disposeBag)
    }
    
    func search(with keyword: String) {
        self.searchStateSubject.onNext(.loading)
        
        searchArtworksUseCase.execute(keyword: keyword).observe(on: scheduler)
            .subscribe(onNext: { response in
                self.searchStateSubject.onNext(.success)
                self.searchDataSubject.onNext(response)
            }) { error in
                self.searchStateSubject.onNext(.failed)
                debugPrint("search error:\(error)")
            }.disposed(by: disposeBag)
    }
    
    func setArtworksData(with data: [Artwork], isLoadMore: Bool = false) {
        if isLoadMore {
            self.artworksData = self.artworksData + data
        } else {
            self.artworksData = data
        }
    }
    
    func getArtworksData() -> [Artwork] {
        return self.artworksData
    }
    
    func getArtworksData(at index: Int) -> Artwork {
        return self.artworksData[index]
    }
    
    func clearArtworksData() {
        self.artworksData.removeAll()
    }
}
