//
//  FeedModel.swift
//  RedditAPI
//
//  Created by Yagmur Egilmez on 8/17/21.
//

import Foundation

struct Welcome: Codable {
    let data: WelcomeData
}

struct WelcomeData: Codable {
    let after: String
    let children: [Child]
}

struct Child: Codable {
    let data: ChildData
}

struct ChildData: Codable {
    let title: String?
    let numComments: Int
    let score: Int
    let thumbnail: String?
    let thumbnailHeight: Int?
    let thumbnailWidth: Int?
    
    enum CodingKeys: String, CodingKey {
        case title
        case numComments = "num_comments"
        case score
        case thumbnail
        case thumbnailHeight = "thumbnail_height"
        case thumbnailWidth = "thumbnail_width"
    }
            
}

