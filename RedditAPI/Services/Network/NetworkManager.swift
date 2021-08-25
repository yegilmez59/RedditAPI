//
//  NetworkManager.swift
//  RedditAPI
//
//  Created by Yagmur Egilmez on 8/24/21.
//

import Foundation
import Combine

class NetworkManager: NetworkService {
    
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func get(from url: URL) -> AnyPublisher<Data, Error> {
        session
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .mapError { failure in
                return NSError(domain: URLError.errorDomain, code: failure.code.rawValue, userInfo: failure.errorUserInfo)
            }
            .eraseToAnyPublisher()
    }
    
}
