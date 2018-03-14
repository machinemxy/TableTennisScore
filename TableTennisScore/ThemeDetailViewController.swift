//
//  ThemeDetailViewController.swift
//  TableTennisScore
//
//  Created by 马学渊 on 2018/02/25.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import UIKit
import StoreKit
import SwiftyStoreKit

class ThemeDetailViewController: UIViewController{
	var themeId: Int = 0
	var purchaseId: String = ""

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var btnPurchase: UIButton!
	@IBOutlet weak var btnRestore: UIButton!
	@IBOutlet weak var btnApply: UIButton!
	
	
	@IBAction func purchaseClicked(_ sender: Any) {
		SwiftyStoreKit.purchaseProduct(purchaseId, quantity: 1, atomically: true) { result in
			switch result {
			case .success:
				UserDefaults.standard.set(true, forKey: self.purchaseId)
				self.unlock()
				//apple already has its own pop up message
				//self.showSimpleDialog(title: NSLocalizedString("Purchase Succeeded", comment: ""))
			case .error:
				self.showSimpleDialog(title: NSLocalizedString("Purchase Failed", comment: ""))
			}
		}
	}
	
	@IBAction func restoreClicked(_ sender: Any) {
		SwiftyStoreKit.restorePurchases(atomically: true) { results in
			if results.restoreFailedPurchases.count > 0 {
				self.showSimpleDialog(title: NSLocalizedString("Restore Failed", comment: ""))
			}
			else if results.restoredPurchases.count > 0 {
				for restoredPurchase in results.restoredPurchases {
					UserDefaults.standard.set(true, forKey: restoredPurchase.productId)
				}
				if UserDefaults.standard.bool(forKey: self.purchaseId) {
					self.unlock()
				}
				self.showSimpleDialog(title: NSLocalizedString("Restore Succeeded", comment: ""))
			}
			else {
				self.showSimpleDialog(title: NSLocalizedString("Nothing to Restore", comment: ""))
			}
		}
	}
	
	
	override func viewDidLoad() {
        super.viewDidLoad()

        //Show theme image
		imageView.image = ThemeController.getPreview(themeId: themeId)
		
		//set purchaseId
		purchaseId = ThemeController.getThemePurchaseId(themeId: themeId)
		
		//According to the purchase situation, set the ability of buttons
		if purchaseId == "" {
			//free theme
			btnPurchase.isEnabled = false
			btnRestore.isEnabled = false
		} else {
			//set the price of the theme
			setPrice(purchaseId: purchaseId)
			
			if isPurchased(purchaseId: purchaseId) {
				//user has bought it
				btnPurchase.isEnabled = false
				btnRestore.isEnabled = false
			} else {
				//user has not bought it
				btnApply.isEnabled = false
			}
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func isPurchased(purchaseId: String) -> Bool {
		return UserDefaults.standard.bool(forKey: purchaseId)
	}
	
	func setPrice(purchaseId: String) {
		SwiftyStoreKit.retrieveProductsInfo([purchaseId]) { result in
			if let product = result.retrievedProducts.first {
				var purchaseTitle = NSLocalizedString("Purchase for @", comment: "")
				let priceString = product.localizedPrice!
				purchaseTitle = purchaseTitle.replacingOccurrences(of: "@", with: priceString)
				self.btnPurchase.setTitle(purchaseTitle, for: .normal)
				print("Product: \(product.localizedTitle), price: \(priceString)")
			} else if let invalidProductId = result.invalidProductIDs.first {
				print("Invalid product identifier: \(invalidProductId)")
			} else {
				print("Error")
			}
		}
	}
	
	func unlock() {
		btnApply.isEnabled = true
		btnPurchase.isEnabled = false
		btnRestore.isEnabled = false
	}
	
	func showSimpleDialog(title: String) {
		let alertController = UIAlertController(title: title, message: "", preferredStyle: .alert)
		let alertAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
		alertController.addAction(alertAction)
		self.present(alertController, animated: true, completion: nil)
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
