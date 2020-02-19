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
}
