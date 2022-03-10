//
//  TweetterInteractorProtocol.swift
//  tweeterApp
//
//  Created by Yuliya Martsenko on 12.02.2022.
//

import Foundation

protocol TweetterInteractorProtocol {
    func getNumberOfTweets() -> Int?
    func getTweet(_ index: Int) -> TweetModel?
}
