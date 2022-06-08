//
//  RequestConfig.swift
//  AllDemoGitApi
//
//  Created by C879403 on 27/05/22.
//

import Foundation

enum EnvironmentHost: String {
    case production = "api.jsonserve.com" 
    case development = ""
}

enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
}

protocol FetchAPIData {
    var path: String { get set }
    var method: String { get set }
    func getAPIData(_ completion: @escaping (Result<HomeUsersModel, Error>?) -> Void) -> Void
}

class NetworkManager: FetchAPIData {
    
    var path: String
    var method: String
    private let session: URLSession
    
    init(session: URLSession, path: String, method: String) {
        self.session = session
        self.path = path
        self.method = method
    }
    
    func getAPIData(_ completion: @escaping (Result<HomeUsersModel, Error>?) -> Void) -> Void {
        
        guard let request = try? buildRequest() else {
            return
        }
        
        let task = session.dataTask(with: request) { data, response, error in
            
            if let data = data {
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    do {
                        let json = try JSONDecoder().decode(HomeUsersModel.self, from: data)
                        completion(.success(json))
                    } catch let error {
                        completion(.failure(error))
                    }
                } else {
                    completion(.failure(NSError(domain: "Data error", code: 400, userInfo: nil)))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func buildRequest() throws -> URLRequest {
        
        // Construct a URL by assigning its parts to a URLComponents value
        var components = URLComponents()
        components.scheme = "https"
        components.host = EnvironmentHost.production.rawValue
        components.path = self.path
        
        // This will give us the constructed URL as an optional
        guard let url = components.url else {
            throw NSError(domain: "Invalid URL", code: 10, userInfo: nil)
        }
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
        request.httpMethod = self.method
        return request
    }
}



