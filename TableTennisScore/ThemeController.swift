//
//  ThemeRow.swift
//  TableTennisScore
//
//  Created by 马学渊 on 2018/02/25.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import UIKit

struct ThemeController {
	static let freeCount = 5
	
	static func getTheme(themeId: Int) -> Theme {
		return Theme(themeId: themeId)
	}
	
	static func getThemeName(themeId: Int) -> String {
		switch themeId {
		case 1:
			return NSLocalizedString("Dark", comment: "")
		case 2:
			return NSLocalizedString("Table Tennis Table", comment: "")
		case 3:
			return NSLocalizedString("Spring Festival", comment: "")
		case 4:
			return NSLocalizedString("Soccer Field", comment: "")
		default:
			return NSLocalizedString("Default", comment: "")
		}
	}
	
	static func getPreview(themeId: Int) -> UIImage {
		switch themeId {
		case 1:
			return #imageLiteral(resourceName: "theme-dark")
		case 2:
			return #imageLiteral(resourceName: "theme-table")
		case 3:
			return #imageLiteral(resourceName: "theme-spring")
		case 4:
			return #imageLiteral(resourceName: "theme-soccer")
		default:
			return #imageLiteral(resourceName: "theme-default")
		}
	}
}
