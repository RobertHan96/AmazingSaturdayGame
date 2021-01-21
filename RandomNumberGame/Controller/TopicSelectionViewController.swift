//
//  TopicSelectionViewController.swift
//  RandomNumberGame
//
//  Created by HanaHan on 2021/01/19.
//

import UIKit
import DropDown
import SnapKit

class TopicSelectionViewController: UIViewController {
    @IBOutlet weak var selectionTitleLabel: UILabel!
    @IBOutlet weak var dropdownMenuAnchorView: UIView!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        setLevelSelectionMenu()

    }
    
//    private func setLevelSelectionMenu() {
//        let dropdown = DropDown()
//        dropdown.dataSource = [GameData.Topic.Song.toString, GameData.Topic.Movie.toString, GameData.Topic.Wisdom.toString]
//        dropdown.anchorView = dropdownMenuAnchorView
//        dropdown.selectedTextColor = .blue
//        dropdown.show()
//
//        dropdown.selectionAction = { [unowned self] (index: Int, item: String) in
//            defaults.set(item, forKey: "gameTopic")
//            selectionTitleLabel.text = item
//        }
//    }
    
    @IBAction func doneTopicSelection(_ sender: UIButton) {
        let viewControllerID = Ids.ViewControllerID.gameVC.id
        guard let gameVC = self.storyboard?.instantiateViewController(withIdentifier: viewControllerID) as? GameViewController
            else { return }
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
}
