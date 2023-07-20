//
//  NetworkManager.swift
//  CardsHearthstone
//
//  Created by Lucas Santana Brito on 20/07/23.
//

import Foundation

protocol NetworkManagerProtocol: AnyObject {
    func performDataTask<T: Decodable>(route: Routes, httpMethod: HTTPMethod, completionHandler: @escaping (Result<T, NetworkError>) -> Void)
}

final class NetworkManager {
    // MARK: - Private Variables
    private let baseURL: String = "https://api.hearthstonejson.com/v1/latest/ptBR/"
    
    // MARK: - Private Methods
    private func makeURLRequest(route: Routes, httpMethod: HTTPMethod = .get) -> URLRequest? {
        let urlString = baseURL + route.endpoint
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        return urlRequest
    }
}

// MARK: - NetworkManagerProtocol
extension NetworkManager: NetworkManagerProtocol {
    func performDataTask<T: Decodable>(route: Routes, httpMethod: HTTPMethod = .get, completionHandler: @escaping (Result<T, NetworkError>) -> Void) {
        guard let urlRequest = makeURLRequest(route: route) else {
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
