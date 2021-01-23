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
            make.left.equalTo(self.view.snp.left).offset(0)
            make.right.equalTo(self.view.snp.right).offset(0)
            make.bottom.greaterThanOrEqualTo(self.view.snp.bottom).offset(-30)
        }
    }
    
    func showCards() {
        self.letterColectionView.visibleCells.forEach { (eachCell) in
            let cell = eachCell as! NumberCollectionViewCell
            cell.numberLabel.isHidden = false
        }
    }
    
    func hideCards() {
        self.letterColectionView.visibleCells.forEach { (eachCell) in
            let cell = eachCell as! NumberCollectionViewCell
            if cell.isOpen == false {
                cell.numberLabel.isHidden = true
            }
        }
    }

    func initCards() {
        self.letterColectionView.visibleCells.forEach { (eachCell) in
            let cell = eachCell as! NumberCollectionViewCell
            cell.numberLabel.isHidden = true
            cell.isOpen = false
            cell.backgroundColor = .brown
        }
    }

    func timeNotiAnimation() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1.0) {
                self.view.alpha = 0.8
                self.view.alpha = 1.0
            }
        }
    }
    
    func moveToGameOver() {
        DispatchQueue.main.async {
            let id = Ids.ViewControllerID.gameOverVC.id
            guard let gameOverVC = self.storyboard?.instantiateViewController(withIdentifier: id) as? GameOverViewController
                else { return }
            self.navigationController?.pushViewController(gameOverVC, animated: true)
        }
    }
    
    func moveToGameClear() {
        let id = Ids.ViewControllerID.gameClearVC.id
        guard let gameClearVC = self.storyboard?.instantiateViewController(withIdentifier: id) as? GameClearViewController
            else { return }
        self.navigationController?.pushViewController(gameClearVC, animated: true)
    }
}
