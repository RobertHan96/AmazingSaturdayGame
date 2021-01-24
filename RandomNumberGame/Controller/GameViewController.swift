import UIKit
import Toast_Swift
import AVFoundation

class GameViewController: UIViewController {
    let defaults = UserDefaults.standard
    let notificationCenter = NotificationCenter.default
    var previewTime : Double =  GameData.Level.level1.preViewTime
    var hintTime : Double =  GameData.Level.level1.hintTime
    var gameTimer : Timer?
    var tempRestTime : Int?
    var restTime : Int = 60 {
        didSet {
            if self.restTime == 30 {
                timeNotiAnimation()
            }
            if self.restTime == 10 {
                timeNotiAnimation()
            }
        }
    }
    var numbers : [Int] = []
    var prevNumber = 0  {
        didSet {
            if self.prevNumber == 20 {
                UINotificationFeedbackGenerator().notificationOccurred(.success)
                moveToGameClear()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getUserLevelInfo()
        setupUI()
//        setupObserver()
        setupColectionView()
        makeAutoLayout()
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)

        notificationCenter.addObserver(self, selector: #selector(appCameToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startGame()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        notificationCenter.removeObserver(self)
    }
        
    private func setupObserver() {
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)

        notificationCenter.addObserver(self, selector: #selector(appCameToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc func appMovedToBackground() {
        print("LOG - 백그라운드 이동 남은시간 : \(restTime)초")
        tempRestTime = restTime
   }

    @objc func appCameToForeground() {
        if let time = tempRestTime {
            print("LOG - 포그라운드 복귀 남은시간 : \(restTime)초")
            restTime = time
        }
   }
    
    private func setupColectionView() {
        letterColectionView.dataSource = self
        letterColectionView.delegate = self
    }
    
    private func getUserLevelInfo() {
        let gameLevel = defaults.string(forKey: "gameLevel") ?? GameData.Level.level1.text
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

    private func startGame() {
        // 게임시작 안내 & 힌트판 제공 시간동안 중복 터치를 막기 위해 화면 터치 잠금
        UIApplication.shared.beginIgnoringInteractionEvents()
        makeRandomNumbers()
        restTime = 60
        DispatchQueue.main.async {
            self.scroeText.text = GameData.Text.defaultScoreZero.text
        }
        // 지정한 힌트 시간 이후에 숫자판이 닫히면서 게임 시작, 게임 시작 안내 토스트
        DispatchQueue.main.asyncAfter(deadline: .now() + previewTime ) {
            self.view.makeToast(GameData.Text.gameStart.text, duration: 1, position: .center)
            UIApplication.shared.endIgnoringInteractionEvents()
            self.hideCards()
            self.setupTimer()
        }
    }
    
    private func makeRandomNumbers() {
        for i in 1...20 {
            numbers.append(i)
        }
        numbers.shuffle()
    }

    // 게임진행 시간 타이머와 힌트 제공 타이머 두개 설정
    private func setupTimer() {
        if let timer = gameTimer {
            if !timer.isValid {
                gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(changeTimerText), userInfo: nil, repeats: true)
        }
        }else{
            gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(changeTimerText), userInfo: nil, repeats: true)
        }
    }

    @objc func changeTimerText(){
        restTime -= 1
        restOfTimeLabel.text = String(restTime)
        if restTime == 0 {
            endGame()
        } else if restTime % 10 == 0 && restTime > 0 {
            print("LOG - \(60 - restTime)초 경과, 힌트 제공")
            showHint()
        }
    }

    @objc func showHint() {
        showCards()        
        DispatchQueue.main.asyncAfter(deadline: .now() + hintTime) {
            self.hideCards()
        }
    }
    
    private func endGame() {
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        let currentScore = Int(scroeText.text!)
        if currentScore == 2000 {
            print("LOG - 게임 끝(GAME CLEAR)")
            moveToGameClear()
        } else {
            print("LOG - 게임 끝(GAME OVER)")
            moveToGameOver()
        }
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
        $0.text = GameData.Text.timeLabel.text
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = .blue
    }
    let restOfTimeLabel = UILabel().then {
        $0.text = GameData.Text.defaultScoreZero.text
        $0.font = UIFont.boldSystemFont(ofSize: 35)
        $0.textColor = .blue
    }
    let scoreInformText = UILabel().then {
        $0.text = GameData.Text.scoreLabel.text
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = .blue
    }
    let scroeText = InsetLabel().then {
        $0.text = GameData.Text.defaultScoreZero.text
        $0.font = UIFont.boldSystemFont(ofSize: 35)
        $0.textColor = .black
        $0.textAlignment = .center
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
            GameData().playGameClearSound()
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
