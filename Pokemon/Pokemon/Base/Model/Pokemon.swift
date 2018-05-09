//
//  Pokemon.swift
//  Pokemon
//
//  Created by Vinicius on 09/05/18.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation

struct Pokemon: Mappable {
    
    var name = ""
    var url = ""
    
    init?(data: Data) {
        
    }
    
    static func ==(lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.name == rhs.name && lhs.url == rhs.url
    }
}
