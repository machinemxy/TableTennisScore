//
//  Scoreboard.swift
//  TableTennisScore
//
//  Created by Ma Xueyuan on 2020/10/17.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class Scoreboard {
    var gameL = BehaviorRelay(value: 0)
    var gameR = BehaviorRelay(value: 0)
    var scoreL = BehaviorRelay(value: 0)
    var scoreR = BehaviorRelay(value: 0)
    var serveL = BehaviorRelay(value: 2)
    var serveR = BehaviorRelay(value: 0)
    var serveFirst = Side.left
    
    func toHistory() -> History {
        History(gameL: gameL.value, gameR: gameR.value, scoreL: scoreL.value, scoreR: scoreR.value, serveL: serveL.value, serveR: serveR.value, serveFirst: serveFirst)
    }
    
    func accept(_ history: History) {
        gameL.accept(history.gameL)
        gameR.accept(history.gameR)
        scoreL.accept(history.scoreL)
        scoreR.accept(history.scoreR)
        serveL.accept(history.serveL)
        serveR.accept(history.serveR)
        serveFirst = history.serveFirst
    }
    
    func mirror() {
        switchValue(a: gameL, b: gameR)
        switchValue(a: scoreL, b: scoreR)
        switchValue(a: serveL, b: serveR)
        serveFirst = serveFirst.revert()
    }
    
    func reset() {
        gameL.accept(0)
        gameR.accept(0)
        scoreL.accept(0)
        scoreR.accept(0)
        serveL.accept(2)
        serveR.accept(0)
        serveFirst = .left
    }
    
    func isLWin() -> Bool {
        scoreL.value >= 11 && scoreL.value - scoreR.value >= 2
    }
    
    func isRWin() -> Bool {
        scoreR.value >= 11 && scoreR.value - scoreL.value >= 2
    }
    
    private func switchValue(a: BehaviorRelay<Int>, b: BehaviorRelay<Int>) {
        let c = a.value
        a.accept(b.value)
        b.accept(c)
    }
}
