//
//  ArtworkCollectionViewCell.swift
//  ArtGalleryApp
//
//  Created by Ari Fajrianda Alfi on 17/09/23.
//

import UIKit
import Kingfisher

class ArtworkCollectionViewCell: UICollectionViewCell {
    
    var data: Artwork? {
        didSet {
            updateUI()
        }
    }
    
    lazy var wrapView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
        view.layer.cornerRadius = 4.0
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12.0, weight: .light)
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config() {
        contentView.addSubview(wrapView)
        wrapView.addSubview(imageView)
        wrapView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            wrapView.topAnchor.constraint(equalTo: contentView.topAnchor),
            wrapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            wrapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            wrapView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: wrapView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: wrapView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: wrapView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4.0),
            titleLabel.leadingAnchor.constraint(equalTo: wrapView.leadingAnchor, constant: 4.0),
            titleLabel.trailingAnchor.constraint(equalTo: wrapView.trailingAnchor, constant: -4.0),
        ])
    }
    
    private func updateUI() {
        guard let data = data else { return }
        imageView.kf.setImage(with: data.imageUrl, placeholder: placeholderImage())
        titleLabel.text = data.title
    }
    
    private func placeholderImage() -> UIImage {
        let view: UIView = UIView()
        view.backgroundColor = .lightGray
        return view.asImage()
    }
}
