//
//  ViewController.swift
//  TableTennisScore
//
//  Created by 马学渊 on 2017/12/21.
//  Copyright © 2017年 Ma Xueyuan. All rights reserved.
//

import UIKit
import StoreKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    private var sb = Scoreboard()
    private var historyManager = HistoryManager()
    private let disposeBag = DisposeBag()

	@IBOutlet weak var scoreLeft: UIButton!
	@IBOutlet weak var scoreRight: UIButton!
	@IBOutlet weak var gameLeft: UIButton!
	@IBOutlet weak var gameRight: UIButton!
	@IBOutlet weak var serveLeft: UILabel!
	@IBOutlet weak var serveRight: UILabel!
	@IBOutlet weak var btnRewind: UIButton!
	@IBOutlet weak var btnChangeSide: UIButton!
	@IBOutlet weak var btnRestartMatch: UIButton!
	@IBOutlet weak var btnSetting: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set theme
        let themeId = UserDefaults.standard.integer(forKey: "themeId")
        let theme = ThemeManager.getTheme(themeId: themeId)
        setTheme(theme: theme)
        
        setupRx()
    }
    
    func setupRx() {
        sb.scoreL
            .asObservable()
            .subscribe(onNext: { [unowned self] value in
                scoreLeft.setTitle("\(value)", for: .normal)
            })
            .disposed(by: disposeBag)
        
        sb.scoreR
            .asObservable()
            .subscribe(onNext: { [unowned self] value in
                scoreRight.setTitle("\(value)", for: .normal)
            })
            .disposed(by: disposeBag)
        
        sb.gameL
            .asObservable()
            .subscribe(onNext: { [unowned self] value in
                gameLeft.setTitle("\(value)", for: .normal)
            })
            .disposed(by: disposeBag)
        
        sb.gameR
            .asObservable()
            .subscribe(onNext: { [unowned self] value in
                gameRight.setTitle("\(value)", for: .normal)
            })
            .disposed(by: disposeBag)
        
        sb.serveL
            .asObservable()
            .subscribe(onNext: { [unowned self] value in
                serveLeft.isHidden = value == 0
            })
            .disposed(by: disposeBag)
        
        sb.serveR
            .asObservable()
            .subscribe(onNext: { [unowned self] value in
                serveRight.isHidden = value == 0
            })
            .disposed(by: disposeBag)
    }
    
	@IBAction func rewind(_ sender: Any) {
        if let history = historyManager.getLast() {
            sb.accept(history)
        }
	}
	
	@IBAction func changeSide(_ sender: Any) {
        backup()
        sb.mirror()
	}
	
	@IBAction func restartMatch(_ sender: Any) {
		backup()
        sb.reset()
	}
	
	@IBAction func addGameLeft(_ sender: Any) {
        backup()
        sb.gameL.accept(sb.gameL.value + 1)
	}
	
	@IBAction func addGameRight(_ sender: Any) {
        backup()
        sb.gameR.accept(sb.gameR.value + 1)
	}
	
	@IBAction func addScoreLeft(_ sender: Any) {
        backup()
        sb.scoreL.accept(sb.scoreL.value + 1)
        if sb.isLWin() {
            gameSet(gameWinner: .left)
        } else {
            processServeChange()
        }
	}
	
	@IBAction func addScoreRight(_ sender: Any) {
		backup()
        sb.scoreR.accept(sb.scoreR.value + 1)
        if sb.isRWin() {
            gameSet(gameWinner: .right)
        } else {
            processServeChange()
        }
	}
	
	@IBAction func unwindFromSetting(segue: UIStoryboardSegue) {
		if segue.identifier != "applySegue" {
			return
		}
		
		//Save the theme user selected
		let themeDetailViewController = segue.source as! ThemeDetailViewController
		UserDefaults.standard.set(themeDetailViewController.themeId, forKey: "themeId")
        
        //Set theme
        let theme = ThemeManager.getTheme(themeId: themeDetailViewController.themeId)
        setTheme(theme: theme)
	}
}
	
private extension ViewController {
	func backup(){
        historyManager.append(history: sb.toHistory())
	}
	
    func gameSet(gameWinner: Side){
		// user use it every 10 time, he will be asked to rate and review
		var gamePlayed = UserDefaults.standard.integer(forKey: "gamePlayed")
		gamePlayed += 1
		UserDefaults.standard.set(gamePlayed, forKey: "gamePlayed")
		if gamePlayed % 10 == 0 {
			SKStoreReviewController.requestReview()
		}
		
        // show alert
		let alertController = UIAlertController(title: NSLocalizedString("Game Set", comment: ""), message: "", preferredStyle: .alert)
		let alertAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: { [unowned self] _ in
            switch gameWinner {
            case .left:
                sb.gameL.accept(sb.gameL.value + 1)
            case .right:
                sb.gameR.accept(sb.gameR.value + 1)
            }
            
            resetForNextGame()
        })
		alertController.addAction(alertAction)
		self.present(alertController, animated: true, completion: nil)
	}
    
    func resetForNextGame(){
        sb.scoreL.accept(0)
        sb.scoreR.accept(0)
        switch sb.serveFirst {
        case .left:
            sb.serveFirst = .right
            sb.serveL.accept(0)
            sb.serveR.accept(2)
        case .right:
            sb.serveFirst = .left
            sb.serveL.accept(2)
            sb.serveR.accept(0)
        }
    }
	
	func processServeChange(){
        if sb.serveL.value > 0 {
            sb.serveL.accept(sb.serveL.value - 1)
            if sb.serveL.value == 0 {
                sb.serveR.accept(getServeCount())
            }
        } else {
            sb.serveR.accept(sb.serveR.value - 1)
            if sb.serveR.value == 0 {
                sb.serveL.accept(getServeCount())
            }
        }
	}
	
	func getServeCount() -> Int{
        if sb.scoreL.value >= 10 && sb.scoreR.value >= 10 {
			return 1
		} else {
			return 2
		}
	}
	
	
	
	func setTheme(theme: Theme) {
		view.backgroundColor = theme.backgroundColor
		
		scoreLeft.setTitleColor(theme.buttonColor, for: .normal)
		scoreRight.setTitleColor(theme.buttonColor, for: .normal)
		gameLeft.setTitleColor(theme.buttonColor, for: .normal)
		gameRight.setTitleColor(theme.buttonColor, for: .normal)
		btnRewind.setTitleColor(theme.buttonColor, for: .normal)
		btnChangeSide.setTitleColor(theme.buttonColor, for: .normal)
		btnRestartMatch.setTitleColor(theme.importantButtonColor, for: .normal)
		
		serveLeft.textColor = theme.labelColor
		serveRight.textColor = theme.labelColor
		
		btnSetting.setImage(theme.settingIcon, for: .normal)
	}
}

#if targetEnvironment(macCatalyst)
extension ViewController: NSTouchBarDelegate {
    override func makeTouchBar() -> NSTouchBar? {
        let touchBar = NSTouchBar()
        touchBar.delegate = self
        touchBar.defaultItemIdentifiers = [.addLeft, .addRight, .rewind, .exchange, .reset]
        return touchBar
    }
    
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
        switch identifier {
        case .addLeft:
            let item = NSButtonTouchBarItem(identifier: identifier, title: NSLocalizedString("Left+1", comment: ""), target: self, action: #selector(addScoreLeft))
            return item
        case .addRight:
            let item = NSButtonTouchBarItem(identifier: identifier, title: NSLocalizedString("Right+1", comment: ""), target: self, action: #selector(addScoreRight))
            return item
        case .rewind:
            let item = NSButtonTouchBarItem(identifier: identifier, title: NSLocalizedString("Rewind", comment: ""), target: self, action: #selector(rewind))
            return item
        case .exchange:
            let item = NSButtonTouchBarItem(identifier: identifier, title: NSLocalizedString("Change Side", comment: ""), target: self, action: #selector(changeSide))
            return item
        case .reset:
            let item = NSButtonTouchBarItem(identifier: identifier, title: NSLocalizedString("Reset", comment: ""), target: self, action: #selector(restartMatch))
            return item
        default:
            return nil
        }
    }
}
#endif
