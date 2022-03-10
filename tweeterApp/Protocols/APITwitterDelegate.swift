//
//  APITwitterDelegate.swift
//  tweeterApp
//
//  Created by Yuliya Martsenko on 12.02.2022.
//

import Foundation

protocol APITwitterDelegate: class {
    func recievedTweetManager(tweets: [TweetModel])
    func recievedErrorManager(error: Error)
}


