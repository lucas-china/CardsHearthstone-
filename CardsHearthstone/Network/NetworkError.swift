//
//  NetworkError.swift
//  CardsHearthstone
//
//  Created by Lucas Santana Brito on 20/07/23.
//

import Foundation

protocol ErrorDescription {
    var errorMessage: String { get }
}

enum NetworkError: Error {
    case networkError
    case invalidURLError
    case urlResponseError
    case dataError
    case decodingError
}

extension NetworkError: ErrorDescription {
    var errorMessage: String {
        switch self {
        case .networkError:
            return "Error in network connection"
        case .invalidURLError:
            return "URL is invalid"
        case .urlResponseError:
            return "Error in url response"
        case .dataError:
            return "Response data is empty"
        case .decodingError:
            return "Error in decoding response data"
        }
    }
}
