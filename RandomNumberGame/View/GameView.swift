//
//  GameView.swift
//  RandomNumberGame
//
//  Created by HanaHan on 2021/01/19.
//

import Foundation
import UIKit
import SnapKit
import Then

extension GameViewController {
 
    func setupUI() {
        view.addSubview(timerImageView)
        view.addSubview(letterColectionView)
        view.addSubview(startInfromText)
        view.addSubview(endInfromText)
        view.addSubview(scoreInformText)
        view.addSubview(scroeText)
    }
    
    func makeAutoLayout() {
        startInfromText.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalTo(self.view.snp.left).offset(10)
        }
        endInfromText.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            make.right.equalTo(self.view.snp.right).offset(-10)
        }
        timerImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalTo(self.startInfromText.snp.right).offset(0)
            make.height.equalTo(25)
            make.width.equalTo(25)
        }
        letterColectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.timerImageView.snp.bottom).offset(20)
            make.left.equalTo(self.view.snp.left).offset(20)
            make.right.equalTo(self.view.snp.right).offset(-20)
        }
        scoreInformText.snp.makeConstraints { (make) in
            make.top.equalTo(self.letterColectionView.snp.bottom).offset(10)
            make.centerX.equalTo(self.view)
        }
        scroeText.snp.makeConstraints { (make) in
            make.top.equalTo(self.scoreInformText.snp.bottom).offset(10)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.view.snp.bottom).offset(-30)
        }
    }
    
    func startTimerAnim() {
        self.timerImageView.snp.remakeConstraints { (remake) in
            remake.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            remake.left.equalTo(self.endInfromText.snp.left).offset(-40)
            remake.height.equalTo(40)
            remake.width.equalTo(40)
        }
        UIView.animate(withDuration: 60, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
}
