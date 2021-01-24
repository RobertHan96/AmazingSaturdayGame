import UIKit
import AVFoundation

class GameOverViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        GameData().playGameOverSound()
        let defaults = UserDefaults.standard
        defaults.setValue(60, forKey: "restTime")
    }
    
    @IBAction func tryAgainBtnAction(_ sender: UIButton) {
        moveToHomeVC()
    }
    
    private func moveToHomeVC() {
        DispatchQueue.main.async {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
}
