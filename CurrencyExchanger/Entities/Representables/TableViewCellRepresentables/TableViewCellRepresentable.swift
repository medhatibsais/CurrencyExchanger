//
//  TableViewCellRepresentable.swift
//  CurrencyExchanger
//
//  Created by Medhat Ibsais on 10/09/2022.
//

import UIKit

/// Table View Cell Representable
protocol TableViewCellRepresentable {
    
    /// Cell height
    var cellHeight: CGFloat { get set }
    
    /// Cell reuse identifier
    var cellReuseIdentifier: String { get set }
    
    /// Is selected
    var isSelected: Bool { get set }
    
    /// Item data index
    var itemDataIndex: Int { get set }
    
    /// Selector type
    var selectorType: String { get set }
}
