//
//  Errors.swift
//  tweeterApp
//
//  Created by Yuliya Martsenko on 12.02.2022.
//

import Foundation

enum TweeterClientAppError: LocalizedError {
    case wrongUrl
    case wrongData
    
    public var errorDescription: String? {
        switch self {
        case .wrongUrl:
            return "Error! URL session data: Can't convert string to URL"
        case .wrongData:
            return "Error! Can't decode data from JSON"
        }
    }
}
