//
//  GameData.swift
//  RandomNumberGame
//
//  Created by HanaHan on 2021/01/19.
//

import Foundation
import AVFoundation
class GameData {

    func playGameClearSound() {
        AudioServicesPlaySystemSound(SystemSoundID(Sound.gameClear.soundId))
    }
    
    func playGameOverSound() {
        AudioServicesPlaySystemSound(SystemSoundID(Sound.gameOver.soundId))
    }

    enum Sound {
        case gameClear
        case gameOver
        
        var soundId: Int {
            switch self {
            case .gameClear: return 1302
            case .gameOver: return 1006
            }
        }
    }
    
    enum Level {
        case level1
        case level2
        case level3
        case userDefaultKey
        
        var preViewTime: Double {
            switch self {
            case .level1:   return 5.0
            case .level2:   return 3.0
            case .level3:   return 1.0
            case .userDefaultKey: return 0.0
            }
        }
        
        var hintTime: Double {
            switch self {
            case .level1:   return 1.0
            case .level2:   return 0.5
            case .level3:   return 0.2
            case .userDefaultKey: return 0.0
            }
        }
        
        var text: String {
            switch self {
            case .level1:   return "상"
            case .level2:   return "중"
            case .level3:   return "하"
            case .userDefaultKey: return "gameLevel"
            }
        }
    }

    enum Text {
        case levelSelectIsNedded
        case gameClear
        case gameOver
        case gameReady
        case gameStart
        case timeLabel
        case scoreLabel
        case defaultScoreZero
        
        var text: String{
            switch self {
            case .levelSelectIsNedded : return "먼저 게임 난이도를 선택해주세요"
            case .gameClear : return "GAME CLEAR!"
            case .gameOver : return "GAME OVER!"
            case .gameReady : return "READY!"
            case .gameStart : return "GAME START!"
            case .scoreLabel : return "SCORE"
            case .timeLabel : return "TIME"
            case .defaultScoreZero : return "0"
            }
        }
    }
    
}
