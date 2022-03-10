//
//  TweeterRequestService.swift
//  tweeterApp
//
//  Created by Yuliya Martsenko on 12.02.2022.
//

import Foundation

protocol TweeterRequestServiceProtocol {
    func loadDataFromAPI (with token: String,
                          by topic: String,
                          completion: @escaping (Result<[TweetNetworkModel], Error>)->Void)
}

final class TweeterRequestService: TweeterRequestServiceProtocol {
    
    let requestCreatingService = RequestCreatingService(host: "api.twitter.com",
                                                        path: "/1.1/search/tweets.json",
                                                        using: ["count": "100",
                                                                "lang": "fr"])

    func loadDataFromAPI (with token: String,
                          by topic: String,
                          completion: @escaping (Result<[TweetNetworkModel], Error>)->Void) {
        requestCreatingService.variables["q"] = topic
        
        guard let request = requestCreatingService.request else {
            completion(.failure(TweeterClientAppError.wrongUrl))
            return
        }
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                completion(.failure(error ?? TweeterClientAppError.wrongUrl))
                return
            }
            do {
                let json = try JSONDecoder().decode(Tweets.self, from: data)
                guard let recievedData = json.statuses else {
                    completion(.failure(TweeterClientAppError.wrongData))
                    return
                }
                var dataModel = [TweetNetworkModel]()
                for tweets in recievedData {
                    dataModel.append(tweets)
                }
                completion(.success(dataModel))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
