//
//  ApiManager.swift
//  MoviesAppSwift
//
//  Created by Anoop on 29.07.22.
//

import Foundation

struct ApiConfiguration {
    var scheme:String
    var host: String
    var apiKey: String
}

protocol ApiManagerProtocol {
    func fetchData<T: Decodable>(endpoint: Endpoint, responseModel: T.Type, completionHandler: @escaping (Result<T, RequestError>) -> Void)
}

public class ApiManager: ApiManagerProtocol {
    
    let apiConfiguration: ApiConfiguration
    private let session = URLSession.shared
    
    init(_ apiConfiguration: ApiConfiguration) {
        self.apiConfiguration = apiConfiguration
    }
    
    func fetchData<T>(endpoint: Endpoint, responseModel: T.Type, completionHandler: @escaping (Result<T, RequestError>) -> Void) where T : Decodable {
        guard let urlRequest = endpoint.urlRequest(self.apiConfiguration) else {
            completionHandler(.failure(.invalidURL))
            return
        }
        let task = session.dataTask(with: urlRequest) { data, response, error in
            
            guard  let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                completionHandler(.failure(.unexpectedStatusCode))
                return
            }
            if data != nil {
                do {
                    let result = try endpoint.decoder.decode(responseModel, from: data!)
                    completionHandler(.success(result))
                } catch {
                    completionHandler(.failure(.decode))
                }
            }
            if error != nil {
                completionHandler(.failure(.unknown))
            }
        }
        task.resume()
    }
}
