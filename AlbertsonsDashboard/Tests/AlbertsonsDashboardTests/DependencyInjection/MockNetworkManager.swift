//
//  MockNetworkManager.swift
//  
//
//  Created by Durgesh Lal on 1/26/23.
//

import Foundation
import AlbertsonsApis
import Combine
@testable import AlbertsonsDashboard

struct MockNetworkManager: NetworkManaging {
    
    func request<T: Decodable>(url: String, params: RequestParameters?) -> AnyPublisher<T, Failure> {
        guard let url = Bundle.module.url(forResource: url, withExtension: "json") else {
            fatalError("Someting wrong fetchinh local json")
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { response -> Data in
                return response.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { Failure.map($0) }
            .eraseToAnyPublisher()
    }
    
    
    func request<T: Decodable>(url: String, params: RequestParameters?) async throws -> T  {
        let model: T = try await withCheckedThrowingContinuation( { continuation in
            guard let url = Bundle.module.url(forResource: url, withExtension: "json") else {
                continuation.resume(throwing: Failure.badUrl)
                return
            }
            let request = URLRequest(url: url)
            Task {
                do {
                    let (data, _) = try await URLSession.shared.data(for: request, delegate: nil)
                    guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
                        continuation.resume(throwing: Failure.parsingError)
                        return
                    }
                    print("Response from asyn await \(decodedResponse)")
                    continuation.resume(returning: decodedResponse)
                } catch {
                    continuation.resume(throwing: Failure.badResponse("error?.localizedDescription"))
                }
            }
        })
        return model
    }
    
    private func process<T: Decodable>(_ data: Data? = nil, callBack: @escaping (Result<T, Failure>) -> Void) {
        if let _data = data {
            let decoder = JSONDecoder()
            if let model = try? decoder.decode(T.self, from: _data) {
                callBack(.success(model))
            } else {
                callBack(.failure(.parsingError))
            }
        }
        callBack(.failure(.badResponse("Microsoft: Error while fetching data from local json")))
    }
    
    func request<T>(url: String, params: RequestParameters?, callBack: @escaping (Result<T, Failure>) -> Void) where T : Decodable {
        
        if let bundlePath = Bundle.module.path(forResource: url, ofType: "json"),
           let data = try? String(contentsOfFile: bundlePath).data(using: .utf8) {
            process(data, callBack: callBack)
        } else {
            fatalError("Microsoft: Error while fetching data from local json")
        }
    }
}
