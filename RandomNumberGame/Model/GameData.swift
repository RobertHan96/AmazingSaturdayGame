//
//  GameData.swift
//  RandomNumberGame
//
//  Created by HanaHan on 2021/01/19.
//

import Foundation

class GameData {

    enum Level {
        case level1
        case level2
        case level3
        
        var preViewTime: Double {
            switch self {
            case .level1:   return 5.0
            case .level2:   return 3.0
            case .level3:   return 1.0
            }
        }
        
        var hintTime: Double {
            switch self {
            case .level1:   return 1.0
            case .level2:   return 0.5
            case .level3:   return 0.2
            }
        }
        
        var toString: String {
            switch self {
            case .level1:   return "상"
            case .level2:   return "중"
            case .level3:   return "하"
            }
        }
    }

}
