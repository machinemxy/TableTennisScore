//
//  Side.swift
//  TableTennisScore
//
//  Created by Ma Xueyuan on 2020/10/17.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import Foundation

enum Side {
    case left, right
    
    func revert() -> Side {
        if self == .left {
            return .right
        } else {
            return .left
        }
    }
}
