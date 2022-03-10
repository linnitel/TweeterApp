//
//  TweetModel.swift
//  tweeterApp
//
//  Created by Yuliya Martsenko on 12.02.2022.
//

import Foundation

struct TweetModel {
    let name: String
    let text: String
    let date: String?
    
    init? (from model: TweetNetworkModel) {
        guard let name = model.user?.name,
              let text = model.text else {
            return nil
        }
        self.name = name
        self.text = text
        self.date = model.user?.date
    }
}

extension TweetModel: CustomStringConvertible {
    var description: String {
        "Name: \(name), Text: \(text), At: \(date ?? "")"
    }
}
