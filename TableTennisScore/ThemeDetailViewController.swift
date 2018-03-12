//
//  ThemeDetailViewController.swift
//  TableTennisScore
//
//  Created by 马学渊 on 2018/02/25.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import UIKit
import StoreKit

class ThemeDetailViewController: UIViewController{
	var themeId: Int = 0

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var btnPurchase: UIButton!
	@IBOutlet weak var btnRestore: UIButton!
	@IBOutlet weak var btnApply: UIButton!
	
	
	@IBAction func purchaseClicked(_ sender: Any) {

	}
	
	@IBAction func restoreClicked(_ sender: Any) {
	}
	
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		imageView.image = ThemeRow(themeId: themeId).getPreview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
