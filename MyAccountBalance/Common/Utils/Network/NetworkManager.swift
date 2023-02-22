//
//  NetworkManager.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/22.
//

import Foundation

class NetworkManager {
    
    // MARK: - Properties
    
    let network: NetworkClient
    
    // MARK: - Initialization
    
    init(with network: NetworkClient = .init()) {
        self.network = network
    }
    
    // MARK: - Methods
    
    func retrieveData<T: Decodable>(service: Service, type: T.Type, completion: @escaping (Result<(T, HTTPURLResponse?), NetworkError>) -> Void) {
        network.request(for: service) { result in
            switch result {
            case .success((let data, let response)):
                guard let data = data else {
                    completion(.failure(.defaultError()))
                    return
                }

                do {
                    let object = try JSONDecoder().decode(T.self, from: data)
                    completion(.success((object, response)))
                } catch let error {
                    completion(.failure(.defaultError(desc: error.localizedDescription)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
