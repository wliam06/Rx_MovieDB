//
//  TableViewSection.swift
//  MovieDB
//
//  Created by William on 06/02/22.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import MovieKit

/// wraps content of a signle table section
protocol TableSectionViewModelProtocol: AnyObject {
    func configureCell(indexPath: IndexPath, value: Any, tableView: UITableView) -> UITableViewCell
    func onSelect(index: Int)
    var items: [Any] { get }
}

/// section model constrained to same data type and same cell type across all section cells
class TableSectionViewModel<ObjectClass, CellClass: UITableViewCell>: TableSectionViewModelProtocol {
    
    private var configureCell: ((_ index: Int, _ value: ObjectClass, _ cell: CellClass) -> ())
    private var onSelect: ((_ index: Int, _ value: ObjectClass) -> ())?
    private var entries: [ObjectClass]
    
    init(entries: [ObjectClass],
         configureCell: @escaping ((_ index: Int, _ value: ObjectClass, _ cell: CellClass) -> ()),
         onSelect: ((_ index: Int, _ value: ObjectClass) -> ())? = nil) {
        self.entries = entries
        self.configureCell = configureCell
        self.onSelect = onSelect
    }
    
    func configureCell(indexPath: IndexPath, value: Any, tableView: UITableView) -> UITableViewCell {
        let cell: CellClass = tableView.dequeueReusableCell(forIndexPath: indexPath)
        configureCell(indexPath.row, value as! ObjectClass, cell)
        return cell
    }
    
    func onSelect(index: Int) {
        guard entries.count > index else { return }
        onSelect?(index, entries[index])
    }
    
    var items: [Any] {
        entries
    }
    
    /// shortcut for abstraction
    var asProtocol: TableSectionViewModelProtocol {
        self as TableSectionViewModelProtocol
    }
    
}

extension TableSectionViewModel where ObjectClass == Int {
    
    /// shortcut to generate a section with a static amount of cells and ignore the data type
    /// - Parameters:
    ///   - cellCount: cell count
    ///   - configureCell: cell configuration
    /// - Returns: section converted to procol for convenience
    static func cells(cellCount: Int = 1, configureCell: @escaping ((_ cell: CellClass) -> ())) -> TableSectionViewModelProtocol {
        TableSectionViewModel(entries: Array(0..<cellCount), configureCell: { _, _, cell in
            configureCell(cell)
        }).asProtocol
    }
    
}

/// section model without data type supporting different types of cells
class TableSectionCellViewModel: TableSectionViewModelProtocol {
    private let configureCell: [(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell]
    private let onSelect: [(() -> ())?]?
    
    init(configureCell: [(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell], onSelect: [(() -> ())?]? = nil) {
        self.configureCell = configureCell
        self.onSelect = onSelect
    }
    
    convenience init(
        configureCell: @escaping (
            _ tableView: UITableView,
            _ indexPath: IndexPath
        ) -> UITableViewCell,
        onSelect: (() -> ())? = nil,
        count: Int = 1
    ) {
        self.init(configureCell: Array(repeating: configureCell, count: count),
                  onSelect: onSelect == nil ? nil : Array(repeating: onSelect!, count: count))
    }
    
    func configureCell(
        indexPath: IndexPath,
        value: Any,
        tableView: UITableView
    ) -> UITableViewCell {
        guard configureCell.count > indexPath.row else { return UITableViewCell() }
        return configureCell[indexPath.row](tableView, indexPath)
    }
    
    func onSelect(index: Int) {
        guard (onSelect?.count ?? 0) > index else { return }
        onSelect?[index]?()
    }
    
    lazy var items: [Any] = Array(0..<configureCell.count)
    
    /// shortcut for abstraction
    var asProtocol: TableSectionViewModelProtocol {
        self as TableSectionViewModelProtocol
    }
}

extension Reactive where Base: UITableView {
    
    func items<Source: ObservableType>(sections: Source)
        -> Disposable
        where Source.Element == [TableSectionViewModelProtocol] {
        let relay = BehaviorRelay<Source.Element>(value: [])
        
        let d1 = sections.bind(to: relay)
        
        let dataSource: RxTableViewSectionedReloadDataSource<SectionModel<Int, Any>> = RxTableViewSectionedReloadDataSource(
            configureCell: { _, tableView, indexPath, item in
            relay.value[indexPath.section].configureCell(indexPath: indexPath, value: item, tableView: tableView)
        })
        
        let d2 = relay
            .map { $0.enumerated().map { SectionModel(model: $0.offset, items: $0.element.items) } }
            .bind(to: self.items(dataSource: dataSource))
        
        let d3 = self.itemSelected
            .subscribe(onNext: { indexPath in
                guard relay.value.count > indexPath.section else { return }
                relay.value[indexPath.section].onSelect(index: indexPath.row)
            })
        
        return CompositeDisposable(d1, d2, d3)
    }
    
    func items<Source: ObservableType>(section: Source) -> Disposable
        where Source.Element == TableSectionViewModelProtocol {
            return items(sections: section.map { [$0] })
    }

}
