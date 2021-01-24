//
//  GameClearViewController.swift
//  RandomNumberGame
//
//  Created by HanaHan on 2021/01/19.
//

import UIKit

class GameClearViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        GameData().playGameClearSound()
        let defaults = UserDefaults.standard
        defaults.setValue(60, forKey: "restTime")
    }
    
    @IBAction func moveToHome(_ sender: UIButton) {
        moveToHomeVC()
    }
    
    private func moveToHomeVC() {
        DispatchQueue.main.async {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }

}
