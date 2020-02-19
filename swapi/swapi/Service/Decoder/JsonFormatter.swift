//
//  JsonFormatter.swift
//  swapi
//
//  Created by Benoit Pasquier on 19/2/20.
//  Copyright © 2020 Benoit Pasquier. All rights reserved.
//

import Foundation

enum ErrorType: Error {
    case wrongFormat
    case wrongUrlRequest
}

final class JsonFormatter {
    
    func decode<T: Decodable>(_ data: Data) -> Result<T,ErrorType> {
        do {
            let element = try JSONDecoder().decode(T.self, from: data)
            return .success(element)
        } catch {
            return .failure(.wrongFormat)
        }
    }
    
    func decode<T: Decodable>(_ result: Result<Data,ErrorType>) -> Result<T,ErrorType> {
        
        switch result {
        case .failure(let error):
            return .failure(error)
            
        case .success(let data):
            return decode(data)
        }
    }
}
