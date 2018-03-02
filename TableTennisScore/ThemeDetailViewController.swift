//
//  ThemeDetailViewController.swift
//  TableTennisScore
//
//  Created by 马学渊 on 2018/02/25.
//  Copyright © 2018年 Ma Xueyuan. All rights reserved.
//

import UIKit
import StoreKit

class ThemeDetailViewController: UIViewController, SKProductsRequestDelegate, SKPaymentTransactionObserver {
	var themeId: Int = 0
	var products = [SKProduct]()

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var btnPurchase: UIButton!
	@IBOutlet weak var btnRestore: UIButton!
	@IBOutlet weak var btnApply: UIButton!
	
	
	@IBAction func purchaseClicked(_ sender: Any) {
		for product in products {
			let prodId = product.productIdentifier
			if(prodId == "theme1") {
				buyProduct(product: product)
			}
		}
	}
	
	@IBAction func restoreClicked(_ sender: Any) {
	}
	
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		imageView.image = ThemeRow(themeId: themeId).getPreview()
		
		if(SKPaymentQueue.canMakePayments()) {
			let productIds = NSSet(object: "theme1") as! Set<String>
			let request = SKProductsRequest(productIdentifiers: productIds)
			request.delegate = self
			request.start()
		} else {
			print("please enable IAPs")
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
		for product in response.products {
			print(product.productIdentifier)
			print(product.localizedTitle)
			print(product.localizedDescription)
			print(product.price)
			products.append(product)
		}
	}
	
	func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
		print("transaction restored")
		for transaction in queue.transactions {
			if let identifier = transaction.transactionIdentifier {
				print(identifier)
			}
		}
	}
	
	func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
		for transaction in transactions {
			switch transaction.transactionState {
			case .purchased:
				print("ok")
				if let identifier = transaction.transactionIdentifier {
					print(identifier)
				}
			case .failed:
				print("failed")
			default:
				print("default")
			}
		}
	}

	func buyProduct(product: SKProduct) {
		print("buy" + product.productIdentifier)
		let pay = SKPayment(product: product)
		SKPaymentQueue.default().add(self)
		SKPaymentQueue.default().add(pay)
		
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
