//
//  Array+Extension.swift
//  Pokemon
//
//  Created by Vinicius on 09/05/18.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation

extension Array {
    func object(index: Int) -> Element? {
        if index >= 0 && index < self.count {
            return self[index]
        }
        return nil
    }
}
