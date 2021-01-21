//
//  Identifiers.swift
//  RandomNumberGame
//
//  Created by HanaHan on 2021/01/19.
//

import Foundation

class Ids {
    enum ViewControllerID {
        case mainVC
        case topicSelectionVC
        case gameVC
        case gameOverVC
        case gameClearVC
        
        var id: String {
            switch self {
            case .mainVC:   return "mainVC"
            case .topicSelectionVC:   return "topicSelectionVC"
            case .gameVC:   return "gameVC"
            case .gameOverVC:   return "gameOverVC"
            case .gameClearVC:   return "gameClearVC"
            }
        }
    }
}
