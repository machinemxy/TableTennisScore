//
//  ThemeRow.swift
//  TableTennisScore
//
//  Created by 马学渊 on 2018/02/25.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import UIKit

struct ThemeController {
	static let rowCount = 3
	
	static func getTheme(themeId: Int) -> Theme {
		return Theme(themeId: themeId)
	}
	
	static func getThemeName(themeId: Int) -> String {
		switch themeId {
		case 1:
			return NSLocalizedString("Dark", comment: "")
		case 2:
			return NSLocalizedString("Spring Festival", comment: "")
		default:
			return NSLocalizedString("Default", comment: "")
		}
	}
	
	static func getPreview(themeId: Int) -> UIImage {
		switch themeId {
		case 1:
			return #imageLiteral(resourceName: "theme-dark")
		case 2:
			return #imageLiteral(resourceName: "theme-spring")
		default:
			return #imageLiteral(resourceName: "theme-default")
		}
	}
	
	static func getThemePurchaseId(themeId: Int) -> String {
		switch themeId {
		case 2:
			return "theme1"
		default:
			return ""
		}
	}
}
