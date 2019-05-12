//
//  UICollectionView.swift
//  PDAppKit
//
//  Created by roy.cao on 2018/10/17.
//  Copyright © 2018 Farfetch. All rights reserved.
//

import UIKit

// MARK: - UICollectionView Registration
public extension UICollectionView {

    func register<T: UICollectionViewCell>(_ classType: T.Type) {
        register(classType, forCellWithReuseIdentifier: classType.reuseIdentifier)
    }

    func register<T: UICollectionViewCell>(_ classType: T.Type) where T: NibLoadableView {
        register(classType, forCellWithReuseIdentifier: classType.reuseIdentifier)
    }
}

// MARK: - Register Suplementary views
public extension UICollectionView {

    func register<T: UICollectionReusableView>(_ classType: T.Type, for supplementaryViewOfKind: String) {
        register(classType, forSupplementaryViewOfKind: supplementaryViewOfKind, withReuseIdentifier: classType.reuseIdentifier)
    }
}

// MARK: - UICollectionView Dequeue
public extension UICollectionView {

    func dequeueCell<T: UICollectionViewCell>(_ classType: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: classType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(classType.reuseIdentifier)")
        }
        return cell
    }
}

// MARK: - UICollectionView Suplementary Views Dequeue
public extension UICollectionView {

    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(_ classType: T.Type, ofKind kind: String, for indexPath: IndexPath) -> T {
        guard let reusableView = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: classType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue reusableView with identifier: \(classType.reuseIdentifier)")
        }
        return reusableView
    }

    func dequeueReusableHeaderView<T: UICollectionReusableView>(_ classType: T.Type, for indexPath: IndexPath) -> T {
        guard let reusableView = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: classType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue reusableView with identifier: \(classType.reuseIdentifier)")
        }
        return reusableView
    }

    func dequeueReusableFooterView<T: UICollectionReusableView>(_ classType: T.Type, for indexPath: IndexPath) -> T {
        guard let reusableView = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: classType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue reusableView with identifier: \(classType.reuseIdentifier)")
        }
        return reusableView
    }
}
