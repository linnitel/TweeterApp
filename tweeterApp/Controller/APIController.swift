//
//  APIController.swift
//  tweeterApp
//
//  Created by Yuliya Martsenko on 12.02.2022.
//

import UIKit

class APIController {
    
    let token : String
    weak var delegate : APITwitterDelegate?
    private var twitterRequestService: TweeterRequestServiceProtocol
    
    var tweets: [TweetModel]?
    
    init(token: String, delegate: APITwitterDelegate?) {
        self.token = token
        self.delegate = delegate
        twitterRequestService = TweeterRequestService()
    }
    
    func tweetReciever(by topic: String) {
        twitterRequestService.loadDataFromAPI(with: token, by: topic) { [weak self] result in
            guard let self = self,
                  let delegate = self.delegate else {
                return
            }
            switch result {
            case .success(let model):
                let dataSource = model.compactMap { TweetModel(from: $0) }
                delegate.recievedTweetManager(tweets: dataSource)
            case .failure(let error):
                delegate.recievedErrorManager(error: error)
            }
        }
    }
}
