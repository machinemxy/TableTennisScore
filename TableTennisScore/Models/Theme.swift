//
//  Theme.swift
//  TableTennisScore
//
//  Created by 马学渊 on 2018/02/25.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import UIKit

struct Theme {
	var backgroundColor: UIColor
	var buttonColor: UIColor
	var importantButtonColor: UIColor
	var labelColor: UIColor
	var settingIcon: UIImage
	
	init(themeId: Int) {
		switch themeId {
		case 1:
			backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
			buttonColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
			importantButtonColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
			labelColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
			settingIcon = #imageLiteral(resourceName: "settings-white")
		case 2:
			backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
			buttonColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
			importantButtonColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
			labelColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
			settingIcon = #imageLiteral(resourceName: "settings-white")
		case 3:
			backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
			buttonColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
			importantButtonColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
			labelColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
			settingIcon = #imageLiteral(resourceName: "settings-yellow")
		case 4:
			backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
			buttonColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
			importantButtonColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
			labelColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
			settingIcon = #imageLiteral(resourceName: "settings-white")
		default:
			backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
			buttonColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
			importantButtonColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
			labelColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
			settingIcon = #imageLiteral(resourceName: "settings-blue")
		}
	}
}
