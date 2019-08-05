//
//  MagicExtensions.swift
//  table_8-5-2019
//
//  Created by Nathaniel Mcdowell on 8/5/19.
//  Copyright © 2019 Nathaniel Mcdowell. All rights reserved.
//

import UIKit

extension UIResponder {
    func next<T: UIResponder>(_ type: T.Type) -> T? {
        return next as? T ?? next?.next(type)
    }

}

extension UITableViewCell {
    var tableView: UITableView?{
        return next(UITableView.self)
    }
    
    var indexPath:IndexPath?{
        return tableView?.indexPath(for: self)
    }
}
