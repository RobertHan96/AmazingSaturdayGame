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
        dropdown.dataSource = [GameData.Level.level1.text, GameData.Level.level2.text, GameData.Level.level3.text]
        dropdown.anchorView = dropdownAnchorView
        dropdown.selectedTextColor = .blue
        dropdown.show()
        
        dropdown.selectionAction = { [unowned self] (index: Int, item: String) in
            defaults.set(item, forKey: GameData.Level.userDefaultKey.text)
            selectionTitleLabel.text = item
        }
    }
    
    @IBAction func doneLevelSelection(_ sender: UIButton) {
        self.notifyGameStart()
    }
    
    private func notifyGameStart() {
        let gameLevel = defaults.string(forKey: GameData.Level.userDefaultKey.text) ?? nil
        
        if gameLevel == nil {
            self.view.makeToast(GameData.Text.levelSelectIsNedded.text, duration: 1, position: .center)
            setLevelSelectionMenu()
        } else {
            UIApplication.shared.beginIgnoringInteractionEvents()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.view.makeToast(GameData.Text.gameReady.text, duration: 1, position: .center)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.view.makeToast(GameData.Text.gameStart.text, duration: 1, position: .center)
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
