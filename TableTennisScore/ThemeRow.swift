//
//  ThemeRow.swift
//  TableTennisScore
//
//  Created by 马学渊 on 2018/02/25.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import UIKit

struct ThemeRow {
	static let rowCount = 3
	var themeId: Int
	var themeName: String
	
	init(themeId: Int) {
		self.themeId = themeId
		switch themeId {
		case 1:
			themeName = NSLocalizedString("Dark", comment: "")
		case 2:
			themeName = NSLocalizedString("Spring Festival", comment: "")
		default:
			themeName = NSLocalizedString("Default", comment: "")
		}
	}
	
	func getPreview() -> UIImage {
		let image: UIImage
		switch themeId {
		case 1:
			image = #imageLiteral(resourceName: "theme-dark")
		case 2:
			image = #imageLiteral(resourceName: "theme-spring")
		default:
			image = #imageLiteral(resourceName: "theme-default")
		}
		return image
	}
}
