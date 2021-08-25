//
//  RedditFeedServiceType.swift
//  RedditAPI
//
//  Created by Yagmur Egilmez on 8/24/21.
//

import Foundation
import Combine

protocol FeedServiceType {
    var networkManager: NetworkService { get }
    func getFeeds(from urlS: String) -> AnyPublisher<Welcome, Error>
    func getImage(from urlS: String) -> AnyPublisher<Data, Error>
}

