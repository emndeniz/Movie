//
//  ServiceProvider.swift
//  Movie
//
//  Created by Mehmet Emin Deniz on 9.03.2021.
//

import Foundation


enum ServiceResult<T> {
    case success(T)
    case failure(Error)
    case empty
}

class ServiceProvider<T: ServiceBase> {
    var urlSession = URLSession.shared

    init() { }

    func load<U>(service: T, decodeType: U.Type, completion: @escaping (ServiceResult<U>) -> Void) where U: Codable {
        call(service.urlRequest) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let resp = try decoder.decode(decodeType, from: data)
                    completion(.success(resp))
                }
                catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            case .empty:
                completion(.empty)
            }
        }
    }
}

extension ServiceProvider {
    private func call(_ request: URLRequest, deliverQueue: DispatchQueue = DispatchQueue.main, completion: @escaping (ServiceResult<Data>) -> Void) {
        urlSession.dataTask(with: request) { (data, _, error) in
            if let error = error {
                deliverQueue.async {
                    completion(.failure(error))
                }
            } else if let data = data {
                deliverQueue.async {
                    completion(.success(data))
                }
            } else {
                deliverQueue.async {
                    completion(.empty)
                }
            }
            }.resume()
    }
}
