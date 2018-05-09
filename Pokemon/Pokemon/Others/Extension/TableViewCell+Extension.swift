//
//  TableViewCell+Extension.swift
//  Pokemon
//
//  Created by Vinicius on 09/05/18.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    class func createCell<T: UITableViewCell>(tableView: UITableView, indexPath: IndexPath) -> T {
        return tableView.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T ?? T()
    }
}
