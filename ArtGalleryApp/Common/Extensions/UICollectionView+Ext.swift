//
//  UICollectionView+Ext.swift
//  ArtGalleryApp
//
//  Created by Ari Fajrianda Alfi on 17/09/23.
//

import UIKit

extension UICollectionView {
  func registerNIBForCell(with cellClass: AnyClass) {
    let className = String(describing: cellClass)
    self.register(UINib(nibName: className, bundle: nil), forCellWithReuseIdentifier: className)
  }
    
  func registerCell<T: UICollectionViewCell>(_ cellClass: T.Type) {
    let className = String(describing: cellClass)
    self.register(cellClass, forCellWithReuseIdentifier: className)
  }
  
  func dequeueCell<T>(with cellClass: T.Type, for indexPath: IndexPath) -> T? {
    return dequeueReusableCell(withReuseIdentifier: String(describing: cellClass), for: indexPath) as? T
  }
  
  func registerNIBForHeader(with cellClass: AnyClass) {
    let className = String(describing: cellClass)
    self.register(UINib(nibName: className, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: className)
  }
    
  func registerCellForFooter(with cellClass: AnyClass) {
    let className = String(describing: cellClass)
      self.register(cellClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: className)
  }
  
  func dequeueHeader<T>(with cellClass: T.Type, for indexPath: IndexPath) -> T? {
    return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: cellClass), for: indexPath) as? T
  }
    
  func setEmptyView(title: String) {
    let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
    messageLabel.text = title
    messageLabel.textColor = .white
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = .center
    messageLabel.sizeToFit()
    
    self.backgroundView = messageLabel;
  }
  
  func restore() {
    self.backgroundView = nil
  }
}
