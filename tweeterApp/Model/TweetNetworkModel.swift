//
//  TweetNetworkModel.swift
//  tweeterApp
//
//  Created by Yuliya Martsenko on 12.02.2022.
//

import Foundation

struct User: Codable {
    let name: String?
    let date: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "screen_name"
        case date = "created_at"
    }
}

struct TweetNetworkModel: Codable {
    let text: String?
    let user: User?
}

struct Tweets: Codable {
    let statuses: [TweetNetworkModel]?
}
