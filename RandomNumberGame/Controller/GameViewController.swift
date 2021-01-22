//
//  GameViewController.swift
//  RandomNumberGame
//
//  Created by HanaHan on 2021/01/19.
//

import UIKit
import Toast_Swift

class GameViewController: UIViewController {
    let defaults = UserDefaults.standard
    var previewTime : Double =  GameData.Level.level1.preViewTime
    var hintTime : Double =  GameData.Level.level1.hintTime
    var gameTimer : Timer?
    var hintTimer: Timer?
    var restTime : Int = 60
    var numbers : [Int] = []
    var prevNumber = 0  {
        didSet {
            if self.prevNumber == 20 {
                moveToGameClear()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getUserLevelInfo()
        makeRandomNumbers()
        setupUI()
        setupColectionView()
        makeAutoLayout()
    }
    
    private func makeRandomNumbers() {
        for i in 1...20 {
            numbers.append(i)
        }
        numbers.shuffle()
    }
    
    private func setupColectionView() {
        letterColectionView.dataSource = self
        letterColectionView.delegate = self
    }
    
    private func getUserLevelInfo() {
        let gameLevel = defaults.string(forKey: "gameLevel") ?? GameData.Level.level1.toString
        switch gameLevel {
        case "상":
            previewTime = GameData.Level.level3.preViewTime
            hintTime = GameData.Level.level3.hintTime
        case "중":
            previewTime = GameData.Level.level2.preViewTime
            hintTime = GameData.Level.level2.hintTime
        case "하":
            previewTime = GameData.Level.level1.preViewTime
            hintTime = GameData.Level.level1.hintTime
        default:
            print("LOG - 게임난이도 정보 불러오기 실패, 기본 난이도로 진행...")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 게임시작 안내 & 힌트판 제공 시간동안 중복 터치를 막기 위해 화면 터치 잠금
        UIApplication.shared.beginIgnoringInteractionEvents()
        startGame()
    }

    

    func startGame() {
        // 지정한 힌트 시간 이후에 숫자판이 닫히면서 게임 시작, 게임 시작 안내 토스트
        DispatchQueue.main.asyncAfter(deadline: .now() + previewTime ) {
            self.view.makeToast("GAME START!", duration: 2, position: .center)
            self.hideCards()
            UIApplication.shared.endIgnoringInteractionEvents()
            self.setupTimer()
        }
    }
    
    private func showCards() {
        self.letterColectionView.visibleCells.forEach { (eachCell) in
            let cell = eachCell as! NumberCollectionViewCell
            cell.numberLabel.isHidden = false
        }
    }
    
    private func hideCards() {
        self.letterColectionView.visibleCells.forEach { (eachCell) in
            let cell = eachCell as! NumberCollectionViewCell
            if cell.isOpen == false {
                cell.numberLabel.isHidden = true
            }
        }
    }

    // 게임진행 시간 타이머와 힌트 제공 타이머 두개 설정
    private func setupTimer() {
        if let timer = gameTimer {
            if !timer.isValid {
                gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(changeTimerText), userInfo: nil, repeats: true)
                hintTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(showHint), userInfo: nil, repeats: true)
        }
        }else{
            gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(changeTimerText), userInfo: nil, repeats: true)
            hintTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(showHint), userInfo: nil, repeats: true)
        }
    }

    @objc func changeTimerText(){
        restTime -= 1
        restOfTimeLabel.text = String(restTime)
        if restTime == 0 {
            endGame()
        }
    }

    @objc func showHint() {
        showCards()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.hideCards()
        }
    }
    
    private func endGame() {
        let currentScore = Int(scroeText.text!)
        if currentScore == 2000 {
            print("LOG - 게임 끝")
            moveToGameClear()
        } else {
            print("LOG - 게임 끝")
            moveToGameOver()
        }
    }
    
    private func moveToGameOver() {
        DispatchQueue.main.async {
            let id = Ids.ViewControllerID.gameOverVC.id
            guard let gameOverVC = self.storyboard?.instantiateViewController(withIdentifier: id) as? GameOverViewController
                else { return }
            self.navigationController?.pushViewController(gameOverVC, animated: true)
        }
    }
    
    private func moveToGameClear() {
        let id = Ids.ViewControllerID.gameClearVC.id
        guard let gameClearVC = self.storyboard?.instantiateViewController(withIdentifier: id) as? GameClearViewController
            else { return }
        self.navigationController?.pushViewController(gameClearVC, animated: true)
    }
    
    let letterColectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
        let layout = UICollectionViewFlowLayout()
        $0.isUserInteractionEnabled = true
        $0.register(UINib.init(nibName: "NumberCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NumberCollectionViewCell")
        $0.backgroundColor = .none
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 10.0
        layout.scrollDirection = .vertical
        $0.collectionViewLayout = layout
    }
    let timeInfromLabel = UILabel().then {
        $0.text = "TIME"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = .blue
    }
    let restOfTimeLabel = UILabel().then {
        $0.text = "0"
        $0.font = UIFont.boldSystemFont(ofSize: 35)
        $0.textColor = .blue
    }
    let scoreInformText = UILabel().then {
        $0.text = "SCORE"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = .blue
    }
    let scroeText = InsetLabel().then {
        $0.text = "0"
        $0.font = UIFont.boldSystemFont(ofSize: 35)
        $0.textColor = .black
        $0.textAlignment = .center
        $0.adjustsFontSizeToFitWidth = true
    }

}

extension GameViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NumberCollectionViewCell", for: indexPath as IndexPath) as? NumberCollectionViewCell else { return UICollectionViewCell() }
        cell.numberLabel.text = "\(numbers[indexPath.row])"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.height / 10)
        let width = (view.frame.width / 4) - 20
        return CGSize(width: width, height: height)
    }
    
    // 각 셀을 누를때마다 정답 여부를 체크하고 UI & 백 로직 수행
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! NumberCollectionViewCell
        let labelNumber = numbers[indexPath.row]
        if labelNumber == prevNumber + 1 {
            print("LOG - 정답 : ",labelNumber)
            
            DispatchQueue.main.async {
                cell.backgroundColor = .red
                cell.numberLabel.isHidden = false
                self.scroeText.text = "\(self.prevNumber * 100)"
            }
            cell.isOpen = true
            prevNumber += 1
        }
    }
    
}
