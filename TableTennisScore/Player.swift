//
//  Player.swift
//  TableTennisScore
//
//  Created by 马学渊 on 2017/12/24.
//  Copyright © 2017年 Ma Xueyuan. All rights reserved.
//

import Foundation

struct Player{
	var game: Int
	var score: Int
	var serveFirst: Bool
	var remainServe: Int
	
	init(serveFirst: Bool){
		game = 0
		score = 0
		self.serveFirst = serveFirst
		if(serveFirst){
			remainServe = 2
		}else{
			remainServe = 0
		}
	}
}
