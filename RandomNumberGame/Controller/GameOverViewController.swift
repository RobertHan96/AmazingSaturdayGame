//
//  GameOverViewController.swift
//  RandomNumberGame
//
//  Created by HanaHan on 2021/01/19.
//

import UIKit

class GameOverViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
    }

    @IBAction func tryAgainBtnAction(_ sender: UIButton) {
        moveToGameVC()
    }
    
    @IBAction func moveToHome(_ sender: UIButton) {
        moveToHomeVC()
    }
    
    private func moveToHomeVC() {
        DispatchQueue.main.async {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }

    private func moveToGameVC() {
        let viewControllerID = Ids.ViewControllerID.gameVC.id
        guard let gameVC = self.storyboard?.instantiateViewController(withIdentifier: viewControllerID) as? GameViewController
            else { return }
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }

    
}
