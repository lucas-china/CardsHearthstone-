//
//  NetworkManager.swift
//  CardsHearthstone
//
//  Created by Lucas Santana Brito on 20/07/23.
//

import Foundation

protocol NetworkManagerProtocol: AnyObject {
    func performDataTask<T: Decodable>(route: Routes, httpMethod: HTTPMethod, headers: [String: String]?, completionHandler: @escaping (Result<T, NetworkError>) -> Void)
}

final class NetworkManager {
    // MARK: - Private Methods
    private func makeURLRequest(route: Routes, httpMethod: HTTPMethod = .get, headers: [String: String]? = nil) -> URLRequest? {
        let urlString = route.endpoint
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = headers
        
        return urlRequest
    }
}

// MARK: - NetworkManagerProtocol
extension NetworkManager: NetworkManagerProtocol {
    func performDataTask<T: Decodable>(route: Routes, httpMethod: HTTPMethod = .get, headers: [String: String]? = nil, completionHandler: @escaping (Result<T, NetworkError>) -> Void) {
        guard let urlRequest = makeURLRequest(route: route, headers: headers) else {
            completionHandler(.failure(.invalidURLError))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                debugPrint(error.localizedDescription)
                completionHandler(.failure(.networkError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                completionHandler(.failure(.urlResponseError))
                return
            }
            
            guard let responseData = data else {
                completionHandler(.failure(.dataError))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: responseData)
                completionHandler(.success(result))
            } catch {
                debugPrint("error occured while decoding = \(error.localizedDescription)")
                completionHandler(.failure(.decodingError))
            }
        }
        
        task.resume()
    }
}
