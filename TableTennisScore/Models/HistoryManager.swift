//
//  HistoryManager.swift
//  TableTennisScore
//
//  Created by Ma Xueyuan on 2020/10/17.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import Foundation

class HistoryManager {
    var histories = [History]()
    
    func append(history: History) {
        if histories.count > 10 {
            histories.removeFirst()
        }
        
        histories.append(history)
    }
    
    func getLast() -> History? {
        guard histories.count > 0 else {
            return nil
        }
        
        let lastHistory = histories.removeLast()
        return lastHistory
    }
}
