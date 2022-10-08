//
//  CollectionViewCellRepresentable.swift
//  CurrencyExchanger
//
//  Created by Medhat Ibsais on 10/09/2022.
//

import UIKit

/// Collection View Cell Representable
protocol CollectionViewCellRepresentable {
    
    /// Cell reuse identifier
    var cellReuseIdentifier: String { get set }
    
    /// Cell size
    var cellSize: CGSize { get set }
}
