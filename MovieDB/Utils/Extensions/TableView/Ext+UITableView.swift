//
//  Ext+UITableView.swift
//  MovieDB
//
//  Created by William on 20/12/21.
//

import UIKit
import RxSwift
import RxCocoa

protocol ReusableView: AnyObject {
    static var reuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView { }
extension UICollectionViewCell: ReusableView { }

extension UITableView {
    func registerCells(_ cellClasses: UITableViewCell.Type...) {
        for type in cellClasses {
            register(type, forCellReuseIdentifier: type.reuseIdentifier)
        }
    }
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }

        return cell
    }
}

extension UICollectionView {
    func registerCells(_ cellClasses: UICollectionViewCell.Type...) {
        for type in cellClasses {
            register(type, forCellWithReuseIdentifier: type.reuseIdentifier)
        }
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }

        return cell
    }
}

extension Reactive where Base: UITableView {
    
    func items<Sequence: Swift.Sequence, Cell: UITableViewCell, Source: ObservableType>
        (cellType: Cell.Type = Cell.self)
        -> (_ source: Source)
        -> (_ configureCell: @escaping (Int, Sequence.Element, Cell) -> Void)
        -> Disposable where Source.Element == Sequence {
        return { source in
            return { configureCell in
                return self.items(cellIdentifier: cellType.reuseIdentifier, cellType: cellType)(source)(configureCell)
            }
        }
    }

}

extension Reactive where Base: UICollectionView {
    
    func items<Sequence: Swift.Sequence, Cell: UICollectionViewCell, Source: ObservableType>
        (cellType: Cell.Type = Cell.self)
        -> (_ source: Source)
        -> (_ configureCell: @escaping (Int, Sequence.Element, Cell) -> Void)
        -> Disposable where Source.Element == Sequence {
        return { source in
            return { configureCell in
                return self.items(cellIdentifier: cellType.reuseIdentifier, cellType: cellType)(source)(configureCell)
            }
        }
    }

}
