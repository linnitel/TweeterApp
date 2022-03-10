//
//  RequestCreatingService.swift
//  tweeterApp
//
//  Created by Yuliya Martsenko on 12.02.2022.
//

import Foundation

final class RequestCreatingService {
    let host: String
    var path: String
    var variables: [String : String] = [:]
    let key: String
    var request: URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = [URLQueryItem(name: variables.first!.key, value: variables.first!.value)]
        for item in variables {
            if item != variables.first! {
                urlComponents.queryItems?.append(URLQueryItem(name: item.key, value: item.value))
            }
        }
        var URLrequest = URLRequest(url: urlComponents.url!)
        URLrequest.setValue("Bearer \(key)", forHTTPHeaderField: "Authorization")
        URLrequest.httpMethod = "GET"
        print(URLrequest)
        return URLrequest
    }
    
    init(host: String, path: String, using variables: [String : String], with key: String = ACCESS_KEY) {
        self.host = host
        self.path = path
        for item in variables {
            self.variables = [:]
            self.variables[item.key] = item.value
        }
        self.key = key
    }
}
