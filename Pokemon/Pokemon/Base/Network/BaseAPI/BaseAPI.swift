//
//  BaseAPI.swift
//  Pokemon
//
//  Created by Vinicius on 09/05/18.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation

protocol Mappable: Codable, Equatable {
    init?(data: Data)
}

protocol Requestable: class {
    associatedtype DataType
    func request(completion: @escaping (_ result: DataType?, _ error: CustomError?) -> Void)
}

struct BaseAPI {
    let base = "https://pokeapi.co/api/v2/pokemon"
}

infix operator <-->

func <--> <T: Mappable>(data: Data?, handle: (type: T.Type, error: Error?)) -> (model: T?, error: CustomError?) {
    
    if let error = handle.error {
        return (nil, CustomError(error: error))
    }
    
    guard let data = data, let model = T(data: data) else {
        return (nil, CustomError(error: handle.error))
    }
    
    return (model, nil)
}
