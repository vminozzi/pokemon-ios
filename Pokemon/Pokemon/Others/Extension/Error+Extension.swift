//
//  Error+Extension.swift
//  Pokemon
//
//  Created by Vinicius on 09/05/18.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation

struct CustomError {
    
    var message = "Ops... ocorreu algum erro =("
    
    init() { }
    
    init(error: Error?) {
        message = error?.localizedDescription ?? ""
    }
}
