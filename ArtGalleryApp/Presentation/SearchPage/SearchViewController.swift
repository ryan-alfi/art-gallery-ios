//
//  SearchViewController.swift
//  ArtGalleryApp
//
//  Created by Ari Fajrianda Alfi on 15/09/23.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController, PageLoadable {
    
    private let viewModel = SearchViewModel()
    private let disposeBag = DisposeBag()
    private var page: Int = 1
    private var isLoading: Bool = false
    private var isLastPage: Bool = false
    private var loadingView: LoadingReusableView?
    private var keyword: String?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupView()
        
        addViewModelObserver()
        fetchRemoteData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    // MARK: - Setup UI
    
    private func setupNavigationController() {
        self.title = "Art Gallery"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        
        setupSearchView()
    }
    
    private func setupSearchView() {
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.rx.text
            .orEmpty
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: {
                self.searchDidFilled($0)
            }).disposed(by: disposeBag)
        self.navigationItem.searchController = search
    }
    
    private func setupView() {
        collectionView.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 16.0, right: 8)
        collectionView.registerCell(ArtworkCollectionViewCell.self)
        collectionView.registerCellForFooter(with: LoadingReusableView.self)
    }
    
    // MARK: - Fetcher and Observer
    
    private func fetchRemoteData() {
        if let keyword {
            viewModel.search(with: keyword)
        } else {
            viewModel.getListArtworks(page: self.page)
        }
    }

    private func addViewModelObserver() {
        disposeBag.insert(
            viewModel.stateSubject
                .subscribe(onNext: { state in
                    switch state {
                    case .loading:
                        self.isLoading = true
                    case .success, .failed:
                        self.isLoading = false
                    }
                }),
            viewModel.artworksDataSubject
                .subscribe(onNext: { result in
                    self.didFinishFetchArtworks(with: result)
                }),
            viewModel.searchStateSubject
                .subscribe(onNext: {
                    switch $0 {
                    case .loading: self.showLoading()
                    case .success, .failed: self.hideLoading()
                    }
                }),
            viewModel.searchDataSubject
                .subscribe(onNext: { result in
                    self.didFinishSearch(with: result)
                })
        )
    }
    
    // MARK: - Helper
    
    private func searchDidFilled(_ keyword: String) {
        if keyword.count > 2 {
            self.keyword = keyword
            fetchRemoteData()
        } else if keyword.count == 0 {
            self.keyword = nil
            viewModel.clearArtworksData()
            fetchRemoteData()
        }
    }
    
    private func didFinishFetchArtworks(with result: ArtworksResponseModel) {
        self.page = result.pagination.currentPage
        
        self.isLastPage = result.data.count == 0 ? true : false
        
        viewModel.setArtworksData(with: result.data, isLoadMore: self.page == 1 ? false : true)
        
        collectionView.reloadData()
    }
    
    private func didFinishSearch(with artworks: [Artwork]) {
        self.page = 1
        self.isLastPage = true
        
        viewModel.setArtworksData(with: artworks)
        self.navigationItem.searchController?.searchBar.endEditing(true)
        
        collectionView.reloadData()
    }

}


// MARK: - UICollectionView Section
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getArtworksData().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(with: ArtworkCollectionViewCell.self, for: indexPath)!
        cell.data = viewModel.getArtworksData(at: indexPath.item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(viewModel.getArtworksData(at: indexPath.item).imageUrl)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds.size
        let widhtSize = (screenSize.width / 3) - 11
        return CGSize(width: widhtSize, height: widhtSize * 1.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.getArtworksData().count - 1 {
            if !isLoading && keyword == nil {
                self.page += 1
                fetchRemoteData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let defaultSize = CGSize(width: collectionView.bounds.size.width, height: 55)
        if self.isLoading {
            return defaultSize
        } else {
            return self.isLastPage ? CGSize.zero : defaultSize
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: LoadingReusableView.self), for: indexPath) as! LoadingReusableView
            loadingView = footerView
            loadingView?.backgroundColor = UIColor.clear
            return footerView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.activityIndicator.startAnimating()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.activityIndicator.stopAnimating()
        }
    }
}
