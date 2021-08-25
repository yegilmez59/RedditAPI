//
//  NetworkManagerType.swift
//  RedditAPI
//
//  Created by Yagmur Egilmez on 8/24/21.
//

import Foundation
import Combine

protocol NetworkService {
    func get(from url: URL) -> AnyPublisher<Data, Error>
}
