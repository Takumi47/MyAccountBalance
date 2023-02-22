//
//  NetworkClient.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/22.
//

import Foundation
import SystemConfiguration

protocol RequestDefinition {
    var baseURL: String { get }
    var path: String { get }
    var method: NetworkClient.Method { get }
    var headers: [String: String]? { get }
    var query: [String: String]? { get }
    var body: Data? { get }
    var returnType: Decodable.Type { get }
}

protocol Cancellable {
    func cancelRequest()
}

extension URLSessionTask: Cancellable {
    func cancelRequest() {
        cancel()
    }
}

class NetworkClient: NSObject, URLSessionDelegate {
    
    // MARK: - Properties
    
    typealias NetworkResponse = (Data?, HTTPURLResponse?)
    
    enum Method: String {
        case get = "GET"
        case post = "POST"
    }
    
    // MARK: - Methods
    
    @discardableResult
    func request(for req: RequestDefinition, completion: @escaping (Result<NetworkResponse, NetworkError>) -> Void) -> Cancellable? {
        guard var url = URL(string: req.baseURL) else {
            completion(.failure(.invalidURL))
            return nil
        }
        
        if !req.path.isEmpty {
            url.appendPathComponent(req.path)
        }
        
        let config = URLSessionConfiguration.default
        if let headers = req.headers {
            config.httpAdditionalHeaders = headers
        }
        let urlSession = URLSession(configuration: config, delegate: self, delegateQueue: nil)
        
        if let query = req.query {
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
            var queryItems: [URLQueryItem] = []
            for (key, val) in query {
                let queryItem = URLQueryItem(name: key, value: val)
                queryItems.append(queryItem)
            }
            urlComponents?.queryItems = queryItems
            url = urlComponents?.url ?? url
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = req.method.rawValue
        urlRequest.httpBody = req.body
        let task = urlSession.dataTask(with: urlRequest) { (data, urlResponse, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(.defaultError(desc: error.localizedDescription)))
                } else {
                    completion(.success((data, urlResponse as? HTTPURLResponse)))
                }
            }
        }
        task.resume()
        return task
    }
    
    func isNetworkAvailable() -> Bool {
        guard let reachability = SCNetworkReachabilityCreateWithName(nil, "https://google.com") else {
            return false
        }
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(reachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return isReachable && !needsConnection
    }
}
