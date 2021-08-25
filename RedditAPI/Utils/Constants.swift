//
//  Constants.swift
//  RedditAPI
//
//  Created by Yagmur Egilmez on 8/24/21.
//

import Foundation

enum Constants_URL {
    static let baseURL = "https://www.reddit.com/.json"
    static let after = "$AFTER_KEY"
    static let feedURL = "\(baseURL)?after=\(after)"
}
