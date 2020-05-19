//
//  UITableViewExtensions.swift
//  InstaMovies
//
//  Created by Ahmed Abd Elaziz on 5/19/20.
//  Copyright © 2020 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func registerCell<Cell: UITableViewCell>(cellClass: Cell.Type) {
        self.register(Cell.self, forCellReuseIdentifier: String(describing: Cell.self))
    }
    
    func dequeue<Cell: UITableViewCell>() -> Cell {
        let identifier = String(describing: Cell.self)
        
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier) as? Cell else {
            fatalError("Error in cell")
        }
        
        return cell
    }
    
}
