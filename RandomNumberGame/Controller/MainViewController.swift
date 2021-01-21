//
//  ViewController.swift
//  RandomNumberGame
//
//  Created by HanaHan on 2021/01/19.
//

import UIKit
import Toast_Swift
import DropDown

class MainViewController: UIViewController {
    @IBOutlet weak var selectionTitleLabel: UILabel!
    @IBOutlet weak var dropdownAnchorView: UIView!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setLevelSelectionMenu()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    private func setLevelSelectionMenu() {
        let dropdown = DropDown()
        dropdown.dataSource = [GameData.Level.level1.toString, GameData.Level.level2.toString, GameData.Level.level3.toString]
        dropdown.anchorView = dropdownAnchorView
        dropdown.selectedTextColor = .blue
        dropdown.show()
        
        dropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            defaults.set(item, forKey: "gameLevel")
            selectionTitleLabel.text = item
        }
    }
    
    @IBAction func doneLevelSelection(_ sender: UIButton) {
        self.notifyGameStart()
    }
    
    private func notifyGameStart() {
        let gameLevel = defaults.string(forKey: "gameLevel") ?? nil
        
        if gameLevel == nil {
            self.view.makeToast("먼저 게임 난이도를 선택해주세요", duration: 1, position: .center)
            setLevelSelectionMenu()
        } else {
            UIApplication.shared.beginIgnoringInteractionEvents()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.view.makeToast("READY!", duration: 1, position: .center)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.view.makeToast("START!", duration: 1, position: .center)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.moveToGameVC()
                }
            })
        }
    }
    
    private func moveToGameVC() {
        let viewControllerID = Ids.ViewControllerID.gameVC.id
        guard let gameVC = self.storyboard?.instantiateViewController(withIdentifier: viewControllerID) as? GameViewController
            else { return }
        self.navigationController?.pushViewController(gameVC, animated: true)
    }

}
