//
//  SearchViewModel.swift
//  ArtGalleryApp
//
//  Created by Ari Fajrianda Alfi on 16/09/23.
//

import RxSwift

final class SearchViewModel: BaseViewModel {
    
    @Injected(\.getListArtworksUseCase)
    var getListArtworksUseCase: GetListArtworksUseCase
    var scheduler: ImmediateSchedulerType = MainScheduler.asyncInstance
    
    let artworksDataSubject = PublishSubject<ArtworksResponseModel>()
    var artworksData = [Artwork]()
    
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
    
}
