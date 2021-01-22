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
        view.addSubview(letterColectionView)
        view.addSubview(timeInfromLabel)
        view.addSubview(restOfTimeLabel)
        view.addSubview(scoreInformText)
        view.addSubview(scroeText)
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    func makeAutoLayout() {
        timeInfromLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerX.equalTo(self.view)
        }
        restOfTimeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.timeInfromLabel.snp.bottom).offset(6)
            make.centerX.equalTo(self.view)
        }
        letterColectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.restOfTimeLabel.snp.bottom).offset(20)
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
            make.bottom.greaterThanOrEqualTo(self.view.snp.bottom).offset(-30)
        }
    }
    
}
