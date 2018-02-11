//
//  ViewController.swift
//  TableTennisScore
//
//  Created by 马学渊 on 2017/12/21.
//  Copyright © 2017年 Ma Xueyuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	var players = (Player(serveFirst: true), Player(serveFirst: false))
	var historyPlayers = (Player(serveFirst: true), Player(serveFirst: false))

	@IBOutlet weak var scoreLeft: UIButton!
	
	@IBOutlet weak var scoreRight: UIButton!
	
	@IBOutlet weak var gameLeft: UIButton!
	
	@IBOutlet weak var gameRight: UIButton!
	
	@IBOutlet weak var serveLeft: UILabel!
	
	@IBOutlet weak var serveRight: UILabel!
	
	@IBOutlet weak var btnRewind: UIButton!
	
	@IBOutlet weak var btnChangeSide: UIButton!
	
	@IBOutlet weak var btnRestartMatch: UIButton!
	
	@IBAction func rewind(_ sender: Any) {
		players = historyPlayers
		refresh()
	}
	
	@IBAction func changeSide(_ sender: Any) {
		backup()
		let tempPlayer = players.0
		players.0 = players.1
		players.1 = tempPlayer
		refresh()
	}
	
	@IBAction func restartMatch(_ sender: Any) {
		backup()
		players = (Player(serveFirst: true), Player(serveFirst: false))
		refresh()
	}
	
	@IBAction func addGameLeft(_ sender: Any) {
		backup()
		players.0.game += 1
		refresh()
	}
	
	@IBAction func addGameRight(_ sender: Any) {
		backup()
		players.1.game += 1
		refresh()
	}
	
	@IBAction func addScoreLeft(_ sender: Any) {
		backup()
		players.0.score += 1
		changeServe()
		refresh()
		if(players.0.score >= 11 && players.0.score - players.1.score >= 2){
			players.0.game += 1
			resetForNextGame()
			gameSet()
		}
	}
	
	@IBAction func addScoreRight(_ sender: Any) {
		backup()
		players.1.score += 1
		changeServe()
		refresh()
		if(players.1.score >= 11 && players.1.score - players.0.score >= 2){
			players.1.game += 1
			resetForNextGame()
			gameSet()
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		//Initialize the view
		refresh()
	}
	
	func backup(){
		historyPlayers = players
	}
	
	func refresh(){
		gameLeft.setTitle("\(players.0.game)", for: .normal)
		gameRight.setTitle("\(players.1.game)", for: .normal)
		scoreLeft.setTitle("\(players.0.score)", for: .normal)
		scoreRight.setTitle("\(players.1.score)", for: .normal)
		serveLeft.isHidden = players.0.remainServe == 0
		serveRight.isHidden = players.1.remainServe == 0
	}
	
	func gameSet(){
		let alertController = UIAlertController(title: NSLocalizedString("Game Set", comment: ""), message: "", preferredStyle: .alert)
		let alertAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: {(_: UIAlertAction) -> Void in self.refresh()})
		alertController.addAction(alertAction)
		self.present(alertController, animated: true, completion: nil)
	}
	
	func changeServe(){
		if(players.0.remainServe > 0){
			//left player just served
			players.0.remainServe -= 1
			if(players.0.remainServe == 0){
				players.1.remainServe = getServeCount()
			}
		}else{
			//right player just served
			players.1.remainServe -= 1
			if(players.1.remainServe == 0){
				players.0.remainServe = getServeCount()
			}
		}
	}
	
	func getServeCount() -> Int{
		if(players.0.score >= 10 && players.1.score >= 10){
			return 1
		}else{
			return 2
		}
	}
	
	func resetForNextGame(){
		players.0.score = 0
		players.1.score = 0
		if(players.0.serveFirst){
			players.0.serveFirst = false
			players.0.remainServe = 0
			players.1.serveFirst = true
			players.1.remainServe = 2
		}else{
			players.0.serveFirst = true
			players.0.remainServe = 2
			players.1.serveFirst = false
			players.1.remainServe = 0
		}
	}
}

