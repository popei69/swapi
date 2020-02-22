//
//  ErrorType.swift
//  swapi
//
//  Created by Benoit PASQUIER on 22/02/2020.
//  Copyright © 2020 Benoit Pasquier. All rights reserved.
//

import Foundation

enum ErrorType: Error {
    case wrongFormat
    case wrongUrlRequest
    case unknown
}

extension ErrorType {
    var localizedDescription: String {
        switch self {
        case .wrongFormat:
            return "The format of the data is invalid"
        case .wrongUrlRequest:
            return "The format of the request is invalid"
        case .unknown:
            return "An unknown error happened. Please try again later"
        }
    }
}
