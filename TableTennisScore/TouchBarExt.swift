//
//  TouchBarExt.swift
//  TableTennisScore
//
//  Created by Ma Xueyuan on 2020/07/11.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

#if targetEnvironment(macCatalyst)
import UIKit

extension NSTouchBarItem.Identifier {
    static let addLeft = NSTouchBarItem.Identifier("addLeft")
    static let addRight = NSTouchBarItem.Identifier("addRight")
    static let rewind = NSTouchBarItem.Identifier("rewind")
    static let exchange = NSTouchBarItem.Identifier("exchange")
    static let reset = NSTouchBarItem.Identifier("reset")
}
#endif
