//
//  ThemeDetailViewController.swift
//  TableTennisScore
//
//  Created by 马学渊 on 2018/02/25.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import UIKit

class ThemeDetailViewController: UIViewController{
	var themeId: Int = 0

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var btnApply: UIButton!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        //Show theme image
		imageView.image = ThemeManager.getPreview(themeId: themeId)
		
    }
}
