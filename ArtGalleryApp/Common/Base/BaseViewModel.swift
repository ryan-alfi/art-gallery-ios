//
//  BaseViewModel.swift
//  ArtGalleryApp
//
//  Created by Ari Fajrianda Alfi on 16/09/23.
//

import RxSwift

enum LoadingState {
    case loading
    case success
    case failed
}

extension LoadingState {
    //TODO: create loading view
    func loadingView() {
        switch self {
        case.loading: print("ShowLoading")
        default: print("hideLoading")
        }
    }
}

class BaseViewModel: NSObject {
    var disposeBag = DisposeBag()
    
    let stateSubject = BehaviorSubject<LoadingState>(value: .success)
    let errorSubject = PublishSubject<Error>()
    
}
