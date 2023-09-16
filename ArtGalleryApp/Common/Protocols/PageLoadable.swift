//
//  PageLoadable.swift
//  ArtGalleryApp
//
//  Created by Ari Fajrianda Alfi on 17/09/23.
//

import UIKit

fileprivate struct K {
    fileprivate static let loadingViewTag = 1234
}

protocol PageLoadable {
    func showLoading()
    func hideLoading()
}

extension PageLoadable where Self: UIViewController {
    func showLoading() {
        let loadingView = UIView()
        loadingView.tag = K.loadingViewTag
        loadingView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingView)
        
        NSLayoutConstraint.activate([
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        view.subviews.forEach { subview in
            if subview.tag == K.loadingViewTag {
                subview.removeFromSuperview()
            }
        }
    }
}
